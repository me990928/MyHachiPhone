//
//  Hachi.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

class Hachi {
    
//    private let calc: Salary
    private let dateTrans = DateTranslator()
    
    private var daySalary = 0

    private let InputVal: InputValue
    
    init(InptVal: InputValue) {
        // 入力部の初期化
        self.InputVal = InptVal
        
        // 時間値の初期化
        self.workTimes.startTimeHour = self.dateTrans.hourTransDec(date: self.InputVal.startTime)
        self.workTimes.endTimeHour = self.dateTrans.hourTransDec(date: self.InputVal.endTime)
        self.workTimes.dayWorkTime = self.workParam.nightWorkStartTime - self.workTimes.startTimeHour - self.InputVal.breakTime
        self.workTimes.nightWorkTime = self.workTimes.endTimeHour - self.workParam.nightWorkStartTime
        self.workTimes.workTime = self.workTimes.endTimeHour - self.workTimes.startTimeHour - self.InputVal.breakTime
        
        // フラグの初期化
        self.workParam.isNightWork = self.workTimes.endTimeHour > self.workParam.nightWorkStartTime
        self.workParam.isOverWork = self.workTimes.workTime > self.workParam.normalWork
        self.workParam.is22UnderOverWork = self.workTimes.workTime > self.workParam.normalWork
        
        // 時給の初期化
//        self.wageVals.wage = self.InputVal.isSpecialWage ? self.InputVal.specialWage : self.InputVal.isHoliday ? self.wageVals.holidayWage : self.wageVals.baseWage
        self.wageVals.wage = if self.InputVal.isSpecialWage {
            self.InputVal.specialWage
        } else if self.InputVal.isHoliday {
            self.wageVals.holidayWage
        } else {
            self.wageVals.baseWage
        }
    }
    
    // 汎用性を考えるなら書き換え可能にしたい
    // 時給
    var wageVals = Wage()
    // 計算に必要なフラグや指数
    private var workParam = WorkParameters()
    // 労働時間の10進化
    private var workTimes = WorkTimes()
    
    // 給料の結果を表示
    func calculateSalary()->(salary: Int, times: SalaryTime){
        let salary = Salary(wages: wageVals, times: workTimes, params: workParam)
//        let salaryRes = workParam.isOverWork ? workParam.isOverWork ? workParam.is22UnderOverWork ? salary.calcOverAfteNightSalary() : salary.calcNightAfterOverSalary() : salary.calcNightSalary() : workParam.isOverWork ? salary.calcOverWorkSalary() : salary.calcNormalSalary()
        let salaryRes = if workParam.isNightWork {
            if workParam.isOverWork{
                if workParam.is22UnderOverWork {
                    salary.calcOverAfteNightSalary()
                } else {
                    salary.calcNightAfterOverSalary()
                }
            } else {
                salary.calcNightSalary()
            }
        } else {
            if workParam.isOverWork {
                salary.calcOverWorkSalary()
            } else {
                salary.calcNormalSalary()
            }
        }
        let timeRes = getWorkTimes(salary: salary)
        return (salary: salaryRes, times: timeRes)
    }
    
    // 時給ごとの労働時間
    func getWorkTimes(salary: Salary)->SalaryTime{
        return salary.workTime
    }
}

