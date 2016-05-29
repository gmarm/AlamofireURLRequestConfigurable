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
    case GetAll()
    case AddNew(name: String, description: String)
    
    // MARK: URLRequestConfigurable
    var configuration: URLRequestConfiguration {
        switch self {
        case .GetAll():
            return (
                method: .GET,
                URLString: APIConfiguration.URLString("/games"),
                parameters: APIConfiguration.parameters(
                    ["field_list": "id,name",
                    "limit": 10]
                ),
                encoding: .URL,
                headers: APIConfiguration.headers
            )
        case .AddNew(let name, let description): // this call does not exist - it's only an example
            return (
                method: .POST,
                URLString: APIConfiguration.URLString("/games/add"),
                parameters: ["name": name, "description": description],
                encoding: .JSON,
                headers: APIConfiguration.headers
            )
        }
    }
}
