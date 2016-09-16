//
//  AlamofireExtensions.swift
//
//  Created by George Marmaridis on 28/05/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Alamofire

extension SessionManager {
    open func request(_ urlRequestConfiguration: URLRequestConfigurable) -> DataRequest {
        /// Creates a `DataRequest` to retrieve the contents of a URL based on the specified `urlRequestConfiguration`.
        ///
        /// - parameter urlRequestConfiguration: The URL request configuration.
        ///
        /// - returns: The created `DataRequest`.
        return self.request(urlRequestConfiguration.urlRequestConfiguration.url,
                            method: urlRequestConfiguration.urlRequestConfiguration.method,
                            parameters: urlRequestConfiguration.urlRequestConfiguration.parameters,
                            encoding: urlRequestConfiguration.urlRequestConfiguration.encoding,
                            headers: urlRequestConfiguration.urlRequestConfiguration.headers)
    }
}

/// Creates a `DataRequest` using the default `SessionManager` to retrieve the contents of a URL based on the
/// specified `urlRequestConfiguration`.
///
/// - parameter urlRequestConfiguration: The URL request configuration.
///
/// - returns: The created `DataRequest`.
public func request(_ urlRequestConfiguration: URLRequestConfigurable) -> DataRequest {
    return Alamofire.request(
        urlRequestConfiguration.urlRequestConfiguration.url,
        method: urlRequestConfiguration.urlRequestConfiguration.method,
        parameters: urlRequestConfiguration.urlRequestConfiguration.parameters,
        encoding: urlRequestConfiguration.urlRequestConfiguration.encoding,
        headers: urlRequestConfiguration.urlRequestConfiguration.headers
    )
}
