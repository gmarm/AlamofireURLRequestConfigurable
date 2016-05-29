//
//  APIConfiguration.swift
//  AlamofireURLRequestConfigurable
//
//  Created by George Marmaridis on 28/05/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

struct APIConfiguration {
    static let baseURLString = "http://www.giantbomb.com/api"
    static let defaultParamaters = ["api_key": "<YOUR_API_KEY_HERE>",
                             "format": "json",]
    static let headers = ["X-Custom-Header-1": "Value1",
                   "X-Custom-Header-2": "Value2"]
}

// MARK: Helpers
extension APIConfiguration {
    static func URLString(path: String) -> String {
        return "\(baseURLString)\(path)"
    }
    
    static func parameters(additionalParameters: [String: AnyObject]) -> [String: AnyObject] {
        var parameters = additionalParameters
        for (key, value) in defaultParamaters {
            parameters[key] = value
        }
        return parameters
    }
}
