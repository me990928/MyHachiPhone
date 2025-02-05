//
//  WorkTime.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/10.
//

import Foundation
import SwiftData

/// SalaryTimeを扱うモデル
class WorkTime {
    var modelContext: ModelContext
    var times: SalaryTime
    
    init(modelContext: ModelContext, times: SalaryTime) {
        self.modelContext = modelContext
        self.times = times
    }
    
    /// 追加
    func insertModel(_ salary: SalaryData){
        let newModel = SalaryTimeData(id: UUID().uuidString, salaryId: salary.id, normalTime: times.normal, singleTime: times.single, doubleTime: times.double)
        modelContext.insert(newModel)
    }
    
    /// アップデート
    func refactorModel(_ salary: SalaryData){
        
        let id = salary.id
        
        do {
            try modelContext.delete(model: SalaryTimeData.self, where: #Predicate { model in
                model.salaryId == id
            })
        } catch {
            print("err")
            return
        }
        
        let newModel = SalaryTimeData(id: UUID().uuidString, salaryId: salary.id, normalTime: times.normal, singleTime: times.single, doubleTime: times.double)
        modelContext.insert(newModel)
    }
}
