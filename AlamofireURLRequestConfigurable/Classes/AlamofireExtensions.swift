//
//  AlamofireExtensions.swift
//
//  Created by George Marmaridis on 28/05/16.
//  Copyright © 2016 George Marmaridis. All rights reserved.
//

import Alamofire

extension Manager {
    public func request(request: URLRequestConfigurable) -> Request {
        return self.request(
            request.configuration.method,
            request.configuration.URLString,
            parameters: request.configuration.parameters,
            encoding: request.configuration.encoding,
            headers: request.configuration.headers
        )
    }
}

public func request(request: URLRequestConfigurable) -> Request {
    return Alamofire.request(
        request.configuration.method,
        request.configuration.URLString,
        parameters: request.configuration.parameters,
        encoding: request.configuration.encoding,
        headers: request.configuration.headers
    )
}
