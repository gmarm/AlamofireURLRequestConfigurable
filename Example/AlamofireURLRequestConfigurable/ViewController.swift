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
        
        Alamofire.Manager.sharedInstance.request(GameRouter.GetAll())
        .validate()
        .responseJSON { response in
            switch response.result {
            case .Success:
                print("Validation Successful")
            case .Failure(let error):
                print(error)
            }
        }
    }
}
