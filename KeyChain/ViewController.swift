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
        
        let password = KeychainService.loadPassword()
        let gg =   KeychainService.clear()
        let dd =  KeychainService.delete(key: password as! String)
        print(gg)
        print(dd)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

