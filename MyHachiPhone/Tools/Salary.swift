//
//  Salary.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

class Salary {
    private let wages: Wage
    private let times: WorkTimes
    private let params: WorkParameters
    
    var workTime: SalaryTime = SalaryTime()
    
    init(wages: Wage, times: WorkTimes, params: WorkParameters) {
        self.wages = wages
        self.times = times
        self.params = params
    }
    
    // 手当なしの時給
    func calcNormalSalary()->Int{
        let salary: Double = times.workTime * Double(wages.wage)
        workTime.normal = times.workTime
        return Int(ceil(salary))
    }
    
    // 残業手当のみ
    func calcOverWorkSalary()->Int{
        let salary: Double = (params.normalWork * Double(wages.wage)) + ((times.workTime - params.normalWork) * Double(wages.wage) * params.singleMultiplier)
        workTime.normal = params.normalWork
        workTime.single = times.workTime - params.normalWork
        return Int(ceil(salary))
    }
    
    // 夜勤手当のみ
    func calcNightSalary()->Int{
        let salary: Double = (times.dayWorkTime * Double(wages.wage)) + (times.nightWorkTime * Double(wages.wage) * params.singleMultiplier)
        workTime.normal = times.dayWorkTime
        workTime.single = times.nightWorkTime
        return Int(ceil(salary))
    }
    
    // 残業して夜勤
    func calcOverAfteNightSalary()->Int{
        let salary: Double = (params.normalWork * Double(wages.wage)) + ((times.dayWorkTime - params.normalWork) * Double(wages.wage) * params.singleMultiplier) + (times.nightWorkTime * Double(wages.wage) * params.doubleMultiplier)
        workTime.normal = params.normalWork
        workTime.single = times.dayWorkTime - params.normalWork
        workTime.double = times.nightWorkTime
        return Int(ceil(salary))
    }
    
    // 夜勤して残業
    func calcNightAfterOverSalary()->Int{
        let salary: Double = (times.dayWorkTime * Double(wages.wage)) + ((params.normalWork - times.dayWorkTime) * Double(wages.wage) * params.singleMultiplier) + ((times.workTime - params.normalWork) * Double(wages.wage) * params.doubleMultiplier)
        workTime.normal = times.dayWorkTime
        workTime.single = params.normalWork - times.dayWorkTime
        workTime.double = times.workTime - params.normalWork
        return Int(ceil(salary))
    }
}

struct SalaryTime {
    var normal: Double = 0
    var single: Double = 0
    var double: Double = 0
}
