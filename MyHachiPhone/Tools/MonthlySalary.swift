//
//  MonthrySalary.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/26.
//

import Foundation
/// データを月毎に扱う
class MonthlySalary {
    
    /// データを月間ごとに仕分け
    func groupByMonth(salaryData: [SalaryData])->[String: [SalaryData]]{
        
        var groupData = [String: [SalaryData]]()
        let calendar = Calendar.current
        
        for data in salaryData {
            let components = calendar.dateComponents([.year, .month], from: data.startTime)
            if let year = components.year, let month = components.month {
                let key = "\(year)-\(String(format: "%02d", month))"
                if groupData[key] != nil {
                    groupData[key]?.append(data)
                } else {
                    groupData[key] = [data]
                }
            }
        }
        return groupData
    }
    
    /// 月の給料を出力
    func monthlySalary(dict:  [String : [SalaryData]], key: String)->Int{
        var monthly: Int = 0
        for data in dict[key] ?? [] {
            monthly += data.salary
        }
        return monthly
    }
}
