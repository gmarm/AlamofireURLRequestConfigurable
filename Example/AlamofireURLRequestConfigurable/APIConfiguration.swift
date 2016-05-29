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
    static let defaultParamaters = ["api_key": APIConfiguration.APIKey(),
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

// MARK: API Key
extension APIConfiguration {
    static private func APIKey() -> String? {
        guard let path = NSBundle.mainBundle().pathForResource("API", ofType: "plist") else {
            print("You need your own API key to use the example - you can create one here: http://www.giantbomb.com/api/")
            return nil
        }
        guard let APIPlistDictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        guard let APIKey = APIPlistDictionary["API_KEY"] else {
            return nil
        }
        return APIKey as? String
    }
}
