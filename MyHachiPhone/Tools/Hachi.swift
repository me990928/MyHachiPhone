//
//  Hachi.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

/// 給与形態モデル
class Hachi {
    
    private let dateTrans = DateTranslator()
    
    /// 入力された値
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
        self.wageVals.wage = if self.InputVal.isSpecialWage {
            // 特殊時給
            self.InputVal.specialWage
        } else if self.InputVal.isHoliday {
            // 休日時給
            self.wageVals.holidayWage
        } else {
            // 通常時給
            self.wageVals.baseWage
        }
    }
    
    // 汎用性を考えるなら書き換え可能にしたい
    // 時給
    var wageVals = Wage()
    /// 計算に必要なフラグや指数
    private var workParam = WorkParameters()
    /// 労働時間の10進化
    private var workTimes = WorkTimes()
    
    /// 給料の結果を表示
    /// - salary: 給料
    /// - time: 労働時間モデル
    func calculateSalary()->(salary: Int, times: SalaryTime){
        
        let salary = Salary(wages: wageVals, times: workTimes, params: workParam)
        
        let salaryRes = if workParam.isNightWork {
            // 10時以降の労働あり
            if workParam.isOverWork{
                // 残業あり
                if workParam.is22UnderOverWork {
                    // 22時より前から残業をしていた
                    salary.calcOverAfteNightSalary()
                } else {
                    // 10時以降から残業開始
                    salary.calcNightAfterOverSalary()
                }
            } else {
                // 夜勤あり残業なし
                salary.calcNightSalary()
            }
        } else {
            // 10時より前に終わる
            if workParam.isOverWork {
                // 残業あり
                salary.calcOverWorkSalary()
            } else {
                // 残業なし
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

