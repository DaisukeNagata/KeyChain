//
//  Keyçhain2.swift
//  KeyChain
//
//  Created by 永田大祐 on 2017/05/08.
//  Copyright © 2017年 永田大祐. All rights reserved.
//

import Foundation
import Security




/* 
 TateruKeyChainService.savePassword(token: "122223")
let ssd = TateruKeyChainService.loadToken()
print(ssd!)
*/

// Constant Identifiers
//let userAccount = "AuthenticatedUser"
let passwordkey = "passwordkey"
let mailKey = "mailKey"
let addressKey = "addressKey"

enum keyChain2{
    case kSecClassValue
    case kSecAttrAccountValue
    case kSecValueDataValue
    case kSecClassGenericPasswordValue
    case kSecAttrServiceValue
    case kSecMatchLimitValue
    case kSecReturnDataValue
    case kSecMatchLimitOneValue
    
    func dd()-> NSString{
        switch self {
        case .kSecClassValue:
            return NSString(format: kSecClass)
        case .kSecAttrAccountValue:
            return NSString(format: kSecAttrAccount)
        case .kSecValueDataValue:
            return NSString(format: kSecValueData)
        case .kSecClassGenericPasswordValue:
            return NSString(format: kSecClassGenericPassword)
        case .kSecAttrServiceValue:
            return NSString(format: kSecAttrService)
        case .kSecMatchLimitValue:
            return NSString(format: kSecMatchLimit)
        case .kSecReturnDataValue:
            return NSString(format: kSecReturnData)
        case .kSecMatchLimitOneValue:
            return NSString(format: kSecMatchLimitOne)
            
        }
    }
    
}
//キーチェーンの設定
public class TateruKeyChainService: NSObject {
    static let token = TateruKeyChainService.loadToken()
    
    /**
     * 保存クエリと負荷クエリを実行する方法が公開されています。
     */
    
    //認証Tokenを保存するKey
    public class func savePassword(token: String) {
        self.save(service: passwordkey , data: token)
    }
    
    //メールアドレスを保存するKey
    public class func mailAddress(token:String) {
        self.save(service: mailKey, data: token)
    }
    
    //アドレスを保存するKey
    public class func userKey(token:String) {
        self.save(service: addressKey, data: token)
    }
    
    //認証Tokenをロードするメソッド
    public class func loadToken() -> String? {
        return self.load(service: passwordkey)
    }
    
    //メールをロードするKey
    public class func loadMailKey() -> String? {
        return self.load(service: mailKey)
    }
    
    //アドレスをロードするKey
    public class func loadUserKey() -> String? {
        return self.load(service: addressKey)
    }
    
        //認証Tokenの削除
        public class func passwordRemove(token:String)->String?
        {
            return self.remove(service: token)
        }
    
        //メールの削除
        public class func mailKeyRemove(token:String)->String?{
            return self.remove(service: token)
    
        }
        //アドレスの削除
        public class func addressRemove(token:String)->String?{
            return self.remove(service: token)
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
        
        let dataFromString: NSData = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)! as NSData
        
        // 新しいデフォルトのキーチェーンクエリをインスタンス化する
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [ keyChain2.self.kSecClassGenericPasswordValue.dd(), service, userAccount, dataFromString], forKeys: [ keyChain2.self.kSecClassValue.dd(),  keyChain2.self.kSecAttrServiceValue.dd(),  keyChain2.self.kSecAttrAccountValue.dd(),  keyChain2.self.kSecValueDataValue.dd()])
        
        //既存のアイテムをすべて削除する
        SecItemDelete(keychainQuery as CFDictionary)
        
        // 新しいキーチェーンアイテムを追加する
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    private class func load(service: String) -> String? {
        // 新しいデフォルトのキーチェーンクエリをインスタンス化する
        // 結果を返すようにクエリに指示する
        //結果を1つのアイテムに限定する
        
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects:
            
            [ keyChain2.self.kSecClassGenericPasswordValue.dd(),
              service, userAccount, kCFBooleanTrue ?? false,  keyChain2.self.kSecMatchLimitOneValue.dd()],
                                                                     forKeys: [ keyChain2.self.kSecClassValue.dd(),
                                                                                keyChain2.self.kSecAttrServiceValue.dd(),
                                                                                keyChain2.self.kSecAttrAccountValue.dd(),
                                                                                keyChain2.self.kSecReturnDataValue.dd(),
                                                                                keyChain2.self.kSecMatchLimitValue.dd()])
        
        var dataTypeRef :AnyObject?
        
        // キーチェーンアイテムを検索する
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
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
            var contentsOfKeychain: String?
    
            if status == errSecSuccess {
                if let retrievedData = dataTypeRef as? NSData {
                    contentsOfKeychain = String(data: retrievedData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                }
            } else {
                print("Nothing was retrieved from the keychain. Status code \(status)")
            }
            
            contentsOfKeychain?.removeAll()
            return contentsOfKeychain
            
        }
}
