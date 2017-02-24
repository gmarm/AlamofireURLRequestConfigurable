//
//  ViewController.swift
//  AlamofireURLRequestConfigurable
//
//  Created by George Marmaridis on 05/28/2016.
//  Copyright (c) 2016 George Marmaridis. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireURLRequestConfigurable

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.SessionManager.default.request(GameRouter.getAll())
        .responseJSON { response in
            print(response.result) // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}
