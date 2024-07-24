//
//  InputViewModel.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

class InputViewModel: ObservableObject {
    @Published var model = InputValue(startTime: Date(), endTime: Date(), breakTime: 0.0, isHoliday: false, specialWage: 0, isSpecialWage: false, isShiftPlan: false)
//    給料
    @Published var salary: Int = 0
    
//    給料計算
    func getSalary()->(salary: Int, times: SalaryTime){
        let hachi = Hachi(InptVal: model)
        return hachi.calculateSalary()
    }
    
}
