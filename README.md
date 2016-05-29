# URLRequestConfigurable for Alamofire

[![Version](https://img.shields.io/cocoapods/v/AlamofireURLRequestConfigurable.svg?style=flat)](http://cocoapods.org/pods/AlamofireURLRequestConfigurable)
[![License](https://img.shields.io/cocoapods/l/AlamofireURLRequestConfigurable.svg?style=flat)](http://cocoapods.org/pods/AlamofireURLRequestConfigurable)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireURLRequestConfigurable.svg?style=flat)](http://cocoapods.org/pods/AlamofireURLRequestConfigurable)

A replacement for Alamofire's `URLRequestConvertible` for even cleaner and flexible type safe routing.

## Wait, but why?

I tried liking `URLRequestConvertible`, I really did! However, I still don't find it particularly clean. Let me explain. This is an example taken [straight from Alamofire's documentation](https://github.com/Alamofire/Alamofire#crud--authorization):
```swift
enum Router: URLRequestConvertible {
    static let baseURLString = "http://example.com"
    static var OAuthToken: String?

    case CreateUser([String: AnyObject])
    case ReadUser(String)
    case UpdateUser(String, [String: AnyObject])
    case DestroyUser(String)

    var method: Alamofire.Method {
        switch self {
        case .CreateUser:
            return .POST
        case .ReadUser:
            return .GET
        case .UpdateUser:
            return .PUT
        case .DestroyUser:
            return .DELETE
        }
    }

    var path: String {
        switch self {
        case .CreateUser:
            return "/users"
        case .ReadUser(let username):
            return "/users/\(username)"
        case .UpdateUser(let username, _):
            return "/users/\(username)"
        case .DestroyUser(let username):
            return "/users/\(username)"
        }
    }

    // MARK: URLRequestConvertible

    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue

        if let token = Router.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        switch self {
        case .CreateUser(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .UpdateUser(_, let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}
```

It's not really easy to understand what's going on here with a quick look, is it? That's because the URL request's configuration is not in a one centralized place, but scattered throughout the implementation. This is what the same example looks like when written using `URLRequestConfigurable`:

```swift
enum Router: URLRequestConfigurable {
    static let baseURLString = "http://example.com"
    static var OAuthToken: String?

    case CreateUser([String: AnyObject])
    case ReadUser(String)
    case UpdateUser(String, [String: AnyObject])
    case DestroyUser(String)

    static func tokenHeader() -> [String: String]? {
        if let token = Router.OAuthToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }

    // MARK: URLRequestConfigurable

    var configuration: URLRequestConfiguration {
        switch self {
        case .CreateUser(let parameters):
            return (
                method: .POST,
                URLString: "\(Router.baseURLString)/users",
                parameters: parameters,
                encoding: .JSON,
                headers: Router.tokenHeader()
            )
        case .ReadUser(let username):
            return (
                method: .GET,
                URLString: "\(Router.baseURLString)/users/\(username)",
                parameters: nil,
                encoding: .URL,
                headers: Router.tokenHeader()
            )
        case .UpdateUser(let username, let parameters):
            return (
                method: .PUT,
                URLString: "\(Router.baseURLString)/users/\(username)",
                parameters: parameters,
                encoding: .URL,
                headers: Router.tokenHeader()
            )
        case .DestroyUser(let username):
            return (
                method: .DELETE,
                URLString: "\(Router.baseURLString)/users/\(username)",
                parameters: nil,
                encoding: .URL,
                headers: Router.tokenHeader()
            )
        }
    }
}
```

Much more readable, right? With `URLRequestConfigurable`, the URL request's configuration is enforced to be declared in one place and one place only! This results in a consistent look across all our Routers, which in return makes our code more readable!

Lets look at [another example from Alamofire](https://github.com/Alamofire/Alamofire#api-parameter-abstraction):

```swift
enum Router: URLRequestConvertible {
    static let baseURLString = "http://example.com"
    static let perPage = 50

    case Search(query: String, page: Int)

    // MARK: URLRequestConvertible

    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]) = {
            switch self {
            case .Search(let query, let page) where page > 1:
                return ("/search", ["q": query, "offset": Router.perPage * page])
            case .Search(let query, _):
                return ("/search", ["q": query])
            }
        }()

        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL

        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}
```

Notice the last 4 lines there. These lines will most likely need to be copy-pasted to many Routers you create. Yikes - that's not nice! And what if you also wanted to add headers?

This is the same example using `URLRequestConfigurable`:
```swift
enum Router: URLRequestConfigurable {
    static let baseURLString = "http://example.com"
    static let perPage = 50

    case Search(query: String, page: Int)

    // MARK: URLRequestConfigurable

    var configuration: URLRequestConfiguration {
        switch self {
        case .Search(let query, let page) where page > 1:
            return (
                method: .GET,
                URLString: "\(Router.baseURLString)/search",
                parameters: ["q": query, "offset": Router.perPage * page],
                encoding: .URL,
                headers: nil
            )
        case .Search(let query, _):
            return (
                method: .GET,
                URLString: "\(Router.baseURLString)/search",
                parameters: ["q": query],
                encoding: .URL,
                headers: nil
            )
        }
    }
}
```

Now it became that much easier adding headers, changing the encoding, or changing the method.

## Usage

Using `URLRequestConfigurable` is as easy as making your Routers conform to the `URLRequestConfigurable` protocol. You can then use `Alamofire` normally to perform the requests like before:

```swift
Alamofire.Manager.sharedInstance.request(Router.Get())
.validate()
.responseJSON { response in
    switch response.result {
    case .Success:
        print("Validation Successful")
    case .Failure(let error):
        print(error)
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

If you want to get results back from GiantBomb (optional), you will need to create your own GiantBomb API key [here](http://www.giantbomb.com/api/).

## Requirements

- [Alamofire](https://github.com/Alamofire/Alamofire)
- iOS 8.0+ / Mac OS X 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 7.3+

## Installation

AlamofireURLRequestConfigurable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AlamofireURLRequestConfigurable', '~> 1.0'
```

## Author

George Marmaridis

- https://github.com/gmarm
- https://twitter.com/gmarmas
- https://www.linkedin.com/in/gmarm
- gmarmas@gmail.com

## License

URLRequestConfigurable is available under the MIT license. See the LICENSE file for more info.
