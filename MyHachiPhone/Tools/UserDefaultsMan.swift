//
//  UserDefaultsMan.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import Foundation

class UserDefaultsMan {
    
    func loadUserDefaultBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func saveUserDefaultBool(value: Bool, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
}
