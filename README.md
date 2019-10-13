# URLRequestConfigurable for Alamofire

[![Version](https://img.shields.io/cocoapods/v/AlamofireURLRequestConfigurable.svg?style=flat)](http://cocoapods.org/pods/AlamofireURLRequestConfigurable)
[![License](https://img.shields.io/cocoapods/l/AlamofireURLRequestConfigurable.svg?style=flat)](http://cocoapods.org/pods/AlamofireURLRequestConfigurable)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireURLRequestConfigurable.svg?style=flat)](http://cocoapods.org/pods/AlamofireURLRequestConfigurable)

A replacement for Alamofire's `URLRequestConvertible` for even cleaner and flexible type safe routing.

## Wait, but why?

This is an example for `URLRequestConvertible` taken [straight from Alamofire's documentation](https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#crud--authorization):
```swift
enum Router: URLRequestConvertible {
    case createUser(parameters: Parameters)
    case readUser(username: String)
    case updateUser(username: String, parameters: Parameters)
    case destroyUser(username: String)

    static let baseURLString = "https://example.com"

    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .readUser:
            return .get
        case .updateUser:
            return .put
        case .destroyUser:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .createUser:
            return "/users"
        case .readUser(let username):
            return "/users/\(username)"
        case .updateUser(let username, _):
            return "/users/\(username)"
        case .destroyUser(let username):
            return "/users/\(username)"
        }
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .createUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .updateUser(_, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }

        return urlRequest
    }
}
```

It's not really easy to understand what's going on here with a quick look, is it? That's because the URL request's configuration is scattered throughout the implementation, also leading to multiple `switch` statements. This is what the same example looks like when written using `URLRequestConfigurable`:

```swift
enum Router: URLRequestConfigurable {
    case createUser(parameters: Parameters)
    case readUser(username: String)
    case updateUser(username: String, parameters: Parameters)
    case destroyUser(username: String)

    static let baseURLString = "http://example.com"

    // MARK: URLRequestConfigurable
    var urlRequestConfiguration: URLRequestConfiguration {
        switch self {
        case .createUser(let parameters):
            return URLRequestConfiguration(url: "\(Router.baseURLString)/users",
                                           method: .post,
                                           parameters: parameters,
                                           encoding: URLEncoding.default)
        case .readUser(let username):
            return URLRequestConfiguration(url: "\(Router.baseURLString)/users/\(username)",
                                           method: .get)
        case .updateUser(let username, let parameters):
            return URLRequestConfiguration(url: "\(Router.baseURLString)/users/\(username)",
                                           method: .put,
                                           parameters: parameters,
                                           encoding: URLEncoding.default)
        case .destroyUser(let username):
            return URLRequestConfiguration(url: "\(Router.baseURLString)/users/\(username)",
                                           method: .delete)
        }
    }
}
```

More structured and readable, right? With `URLRequestConfigurable`, the URL request's configuration is enforced to be declared in one place and one place only. This results in a consistent clean look across all Routers.

Also note that as of version `1.1` all the values but the `url` can be omitted if not needed, reducing the number of lines used even further.

Let's look at [another example from Alamofire](https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#api-parameter-abstraction):

```swift
enum Router: URLRequestConvertible {
    case search(query: String, page: Int)

    static let baseURLString = "https://example.com"
    static let perPage = 50

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .search(query, page) where page > 0:
                return ("/search", ["q": query, "offset": Router.perPage * page])
            case let .search(query, _):
                return ("/search", ["q": query])
            }
        }()

        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}
```

And again, look how the example is transformed into something more pleasant to the eye with `URLRequestConfigurable`:

```swift
enum Router: URLRequestConfigurable {
    case Search(query: String, page: Int)

    static let baseURLString = "http://example.com"
    static let perPage = 50

    // MARK: URLRequestConfigurable
    var urlRequestConfiguration: URLRequestConfiguration {
        switch self {
        case .Search(let query, let page) where page > 1:
            return URLRequestConfiguration(url: "\(Router.baseURLString)/search",
                                           method: .get,
                                           parameters: ["q": query, "offset": Router.perPage * page],
                                           encoding: URLEncoding.default)
        case .Search(let query, _):
            return URLRequestConfiguration(url: "\(Router.baseURLString)/search",
                                           method: .get,
                                           parameters: ["q": query],
                                           encoding: URLEncoding.default)
        }
    }
}
```

## Usage

Using `URLRequestConfigurable` is as easy as making your Routers conform to the `URLRequestConfigurable` protocol. You can then use `Alamofire` normally to perform the requests like before:

```swift
Alamofire.SessionManager.default.request(Router.get())
.responseJSON { response in
    if let JSON = response.result.value {
        print("JSON: \(JSON)")
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

If you want to get results back from GiantBomb (optional), you will need to create your own GiantBomb API key [here](http://www.giantbomb.com/api/).

## Requirements

- [Alamofire](https://github.com/Alamofire/Alamofire)
- iOS 10.0+ / Mac OS X 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 11+

## Installation

### Swift Package Manager

AlamofireURLRequestConfigurable is available through Swift Package Manager. To install
it, simply go to Xcode under `File > Swift Packages > Add Package Dependency...`

### CocoaPods

AlamofireURLRequestConfigurable is also available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

_Swift 5.1_
```ruby
pod 'AlamofireURLRequestConfigurable', '~> 1.2'
```

_Swift 3.0_
```ruby
pod 'AlamofireURLRequestConfigurable', '~> 1.1'
```

_Swift 2.x_
```ruby
pod 'AlamofireURLRequestConfigurable', '1.0.1'
```

## Author

George Marmaridis

- https://github.com/gmarm
- https://twitter.com/gmarmas
- https://www.linkedin.com/in/gmarm
- gmarmas@gmail.com

## License

URLRequestConfigurable is available under the MIT license. See the LICENSE file for more info.
