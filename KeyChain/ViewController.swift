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
        
        let ss = KeychainService.loadPassword()
        let sds = KeychainService.delete(key: "")
  
        let ddd = KeychainService.remove(token: ss!)
        print(ddd)
        print(sds)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

