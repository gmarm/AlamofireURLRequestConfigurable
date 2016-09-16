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
    static let headers = ["X-Custom-Header-1": "Value1",
                          "X-Custom-Header-2": "Value2"]
}

// MARK: Helpers
extension APIConfiguration {
    static func URLString(_ path: String) -> String {
        return "\(baseURLString)\(path)"
    }
}
