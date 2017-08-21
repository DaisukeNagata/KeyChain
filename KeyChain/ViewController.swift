//
//  ViewController.swift
//  KeyChain
//
//  Created by 永田大祐 on 2017/03/12.
//  Copyright © 2017年 永田大祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KeychainService.savePassword(token: "Pa55worD")
        KeychainService.savePassword(token: "Pa55worDD")
        
        let key = KeychainService.loadPassword()
        let chain = KeychainService.delete(key: "")
        let key2 = KeychainService.remove(token: key!)
        print(key!)
        print(chain)
        print(key2!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

