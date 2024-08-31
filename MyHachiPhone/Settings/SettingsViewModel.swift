//
//  SettingsViewModel.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import Foundation

class SettingsViewModel:ObservableObject {
    func editWage(wage: String, completed: @escaping ()->Void) {
        guard let wage = Int(wage) else {
            UserDefaultsMan().saveUserDefault(value: "1100", key: "wage")
            return completed()
        }
        UserDefaultsMan().saveUserDefault(value: wage, key: "wage")
        completed()
    }
    
    func editTeate(teate: Bool) {
        UserDefaultsMan().saveUserDefault(value: teate, key: "teate")
    }
}
