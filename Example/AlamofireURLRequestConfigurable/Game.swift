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
                    ["testKey": "testValue"]
                ),
                encoding: .URL,
                headers: ["X-Custom-Header": "custom header value"]
            )
        case .AddNew(let name, let description):
            return (
                method: .POST,
                URLString: "http://www.example.com/getGames/",
                parameters: ["name": name, "description": description],
                encoding: .JSON,
                headers: ["X-Custom-Header": "custom header value"]
            )
        }
    }
}