//
//  URLRequestConfigurable.swift
//
//  Created by George Marmaridis on 28/05/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Alamofire

public typealias URLRequestConfiguration = (
    method: Alamofire.Method,
    URLString: Alamofire.URLStringConvertible,
    parameters: [String: AnyObject]?,
    encoding: Alamofire.ParameterEncoding,
    headers: [String: String]?
)

public protocol URLRequestConfigurable {
    var configuration: URLRequestConfiguration { get }
}
