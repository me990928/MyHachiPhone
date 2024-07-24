//
//  MonthViewModel.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/15.
//

import Foundation
import SwiftData

class MonthViewModel: ObservableObject {
    @Published var model = MonthModel()
    
    func groupByMonth(salaryData: [SalaryData])->[String: [SalaryData]]{
        
        return MonthlySalary().groupByMonth(salaryData: salaryData)
    }
    
    // 月の給料を出力
    func monthlySalary(dict:  [String : [SalaryData]], key: String)->Int{
        return MonthlySalary().monthlySalary(dict: dict, key: key)
    }
}
