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
        
//        KeychainService.savePassword(token: "Pa55worD")
//        KeychainService.savePassword(token: "Pa55worDD")
        
        let ss = KeychainService.loadPassword()
        
        //let dd =  KeychainService.delete(key: password as! String)
  
        let ddd = KeychainService.remove(token: ss!)
        print(ddd)
        print(ss)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

