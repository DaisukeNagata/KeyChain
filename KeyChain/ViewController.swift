//
//  ViewController.swift
//  KeyChain
//
//  Created by 永田大祐 on 2017/03/12.
//  Copyright © 2017年 永田大祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var key = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        KeychainService.savePassword(token: "loadPassword")

        let chain = KeychainService.delete(key: key )
        let remove = KeychainService.remove(token: key )
        let loadPassword = KeychainService.loadPassword()
        key = KeychainService.loadPassword() ?? ""
        print(key, "1111")
        print(chain)
        print(remove ?? "")
        print(loadPassword ?? "")
    }

}
