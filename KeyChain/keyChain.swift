//
//  keyChain.swift
//  sampleEnum
//
//  Created by 永田大祐 on 2017/03/12.
//  Copyright © 2017年 永田大祐. All rights reserved.
//
//http://aska.hatenablog.com/entry/2014/09/23/042116
//http://stackoverflow.com/questions/37539997/save-and-load-from-keychain-swift
//http://iphonedevsdk.com/forum/iphone-sdk-development/123259-keychain-services-et-swift-3.html
import Foundation
import Security


// Constant Identifiers
let userAccount = "AuthenticatedUser"
let accessGroup = "SecuritySerivice"
let passwordKey = "KeyForPassword"

/**
 * 新規エントリ用のユーザー定義キー
 *注：新しい安全なアイテムの新しいキーを追加し、ロードおよび保存メソッドで使用します
 */
// Arguments for the keychain queries
struct keyChain {
    
static let kSecClassValue = NSString(format: kSecClass)
static let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
static let kSecValueDataValue = NSString(format: kSecValueData)
static let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
static let kSecAttrServiceValue = NSString(format: kSecAttrService)
static let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
static let kSecReturnDataValue = NSString(format: kSecReturnData)
static let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
    
}
public class KeychainService: NSObject {
    
    /**
     * 保存クエリと負荷クエリを実行する方法が公開されています。
     */
    
    
    public class func savePassword(token: String) {
        self.save(service: passwordKey as String, data: token)
    }
    
    public class func loadPassword() -> String? {
        return self.load(service: passwordKey ) as String?
    }
    
    public class func remove(token: String) -> String? {
        return self.remove(service: passwordKey )
    }

    
    class func clear() -> Bool {
        let query = [ kSecClass as String : kSecClassGenericPassword ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
    
    public class func delete(key: String) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key ] as [String : Any]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        print(key,"123456")
        return status == noErr
    }

    /**
     * キーチェーンを照会するための内部メソッド。
     */
    
    private class func save(service: String, data: String) {
        let dataFromString: Data = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)! as Data
        
        // 新しいデフォルトのキーチェーンクエリをインスタンス化する
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [keyChain.kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [keyChain.kSecClassValue, keyChain.kSecAttrServiceValue, keyChain.kSecAttrAccountValue, keyChain.kSecValueDataValue])
        
        //既存のアイテムをすべて削除する
        SecItemDelete(keychainQuery as CFDictionary)
        
        // 新しいキーチェーンアイテムを追加する
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    private class func load(service: String) -> String? {
        // 新しいデフォルトのキーチェーンクエリをインスタンス化する
        // 結果を返すようにクエリに指示する
        //結果を1つのアイテムに限定する
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [keyChain.kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue ?? false, keyChain.kSecMatchLimitOneValue], forKeys: [keyChain.kSecClassValue, keyChain.kSecAttrServiceValue, keyChain.kSecAttrAccountValue, keyChain.kSecReturnDataValue, keyChain.kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // キーチェーンアイテムを検索する
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
    private class func remove(service: String) -> String? {
        // 新しいデフォルトのキーチェーンクエリをインスタンス化する
        // 結果を返すようにクエリに指示する
        //結果を1つのアイテムに限定する
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [keyChain.kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue ?? false, keyChain.kSecMatchLimitOneValue], forKeys: [keyChain.kSecClassValue, keyChain.kSecAttrServiceValue, keyChain.kSecAttrAccountValue, keyChain.kSecReturnDataValue, keyChain.kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // キーチェーンアイテムを検索する
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        contentsOfKeychain = nil
        return contentsOfKeychain as String?
    }

}
