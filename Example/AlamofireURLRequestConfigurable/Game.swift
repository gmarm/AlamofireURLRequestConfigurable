//
//  Game.swift
//  AlamofireURLRequestConfigurable
//
//  Created by George Marmaridis on 28/05/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Alamofire
import AlamofireURLRequestConfigurable

struct Game {
    var id: String?
    var name: String?
}

enum GameRouter: URLRequestConfigurable {
    case getAll()
    case addNew(name: String, description: String)
    
    // MARK: URLRequestConfigurable
    var urlRequestConfiguration: URLRequestConfiguration {
        switch self {
        case .getAll():
            return URLRequestConfiguration(
                url: APIConfiguration.URLString("/games"),
                method: .get,
                parameters: ["field_list": "id,name",
                             "limit": 10,
                             "api_key": "<YOUR_API_KEY_HERE>",
                             "format": "json"],
                encoding: URLEncoding.queryString,
                headers: APIConfiguration.headers
            )
        case .addNew(let name, let description): // this call does not exist - it's only an example
            return URLRequestConfiguration(
                url: APIConfiguration.URLString("/games/add"),
                method: .post,
                parameters: ["name": name, "description": description],
                encoding: JSONEncoding.default,
                headers: APIConfiguration.headers
            )
        }
    }
}
