//
//  SalaryData.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation
import SwiftData

// 給与テーブルのモデル

@Model
final class SalaryData: Identifiable {
    @Attribute(.unique) var id: String
    var startTime: Date
    var endTime: Date
    var breakTime: Double
    var isHoliday: Bool
    var specialWage: Int
    var isSpecialWage: Bool
    var salary: Int
    
    init(id: String, startTime: Date, endTime: Date, breakTime: Double, isHoliday: Bool, specialWage: Int, isSpecialWage: Bool, salary: Int) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.breakTime = breakTime
        self.isHoliday = isHoliday
        self.specialWage = specialWage
        self.isSpecialWage = isSpecialWage
        self.salary = salary
    }
    
    func getMinMaxMonths() -> (minMonth: Int, maxMonth: Int)? {
            let calendar = Calendar.current
            guard let startMonth = calendar.dateComponents([.month], from: startTime).month else {
                return nil
            }
            
            return (minMonth: startMonth, maxMonth: startMonth)
        }
}
