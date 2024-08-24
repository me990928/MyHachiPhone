//
//  InputViewModel.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

// InputViewのVM
class InputViewModel: ObservableObject {
    @Published var model = InputValue(startTime: Date(), endTime: Date(), breakTime: 0.0, isHoliday: false, specialWage: 0, isSpecialWage: false, isShiftPlan: false)
    // 給料
    @Published var salary: Int = 0
    
    /// 給料計算
    func getSalary()->(salary: Int, times: SalaryTime){
        let hachi = Hachi(InptVal: model)
        return hachi.calculateSalary()
    }
    
    // 通知
    func sendShiftLoaclPush(){
        let calendar = Calendar.current
        
        let dateComp = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.model.endTime)
        
        LocalPuschTools().sendLocalPush(dateComp: dateComp)
    }
}
