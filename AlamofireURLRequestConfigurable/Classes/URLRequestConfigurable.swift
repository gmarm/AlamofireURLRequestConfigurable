//
//  URLRequestConfigurable.swift
//
//  Created by George Marmaridis on 28/05/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Alamofire

public struct URLRequestConfiguration {
    let url: Alamofire.URLConvertible
    let method: Alamofire.HTTPMethod
    let parameters: Alamofire.Parameters?
    let encoding: Alamofire.ParameterEncoding
    let headers: Alamofire.HTTPHeaders?
    
    public init(url: Alamofire.URLConvertible,
                method: Alamofire.HTTPMethod = .get,
                parameters: Alamofire.Parameters? = nil,
                encoding: Alamofire.ParameterEncoding = URLEncoding.default,
                headers: Alamofire.HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
}

/// Types adopting the `URLRequestConfigurable` protocol can be used to configure URL requests.
public protocol URLRequestConfigurable {
    /// The URL request configuration.
    var urlRequestConfiguration: URLRequestConfiguration { get }
}
