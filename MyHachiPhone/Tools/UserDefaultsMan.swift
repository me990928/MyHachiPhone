//
//  UserDefaultsMan.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import Foundation

class UserDefaultsMan {
    
    /// UserDefaultのロード
    /// - Parameter key: 任意のUserDefaultのキー
    /// - Returns: 設定した値
    /// - Error: false
    func loadUserDefaultBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    /// UserDefaultのロード
    /// - Parameter key: 任意のUserDefaultのキー
    /// - Returns: 設定した値
    /// - Error: 1100 -> デフォルトの時給
    func loadUserDefaultString(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? "1100"
    }
    
    
    func saveUserDefault(value: Any, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
}
