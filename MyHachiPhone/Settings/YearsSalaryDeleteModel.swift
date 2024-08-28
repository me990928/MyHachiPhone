//
//  YearsSalaryDeleteModel.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import Foundation
import Observation
import SwiftData

@Observable
class YearsSalaryDeleteModel {
    var yearList: [String] = []
    init(salary: [SalaryData]){
        for i in salary {
            let year = DateTranslator().dateComponents(i.startTime).year?.description ?? ""
            
            if yearList.isEmpty || yearList.last != year {
                yearList.append(year)
            }
        }
    }
    
    func yearModelDelete(label: String, salarys: [SalaryData] ,mc: ModelContext){
        for salary in salarys {
            if label == DateTranslator().dateComponents(salary.startTime).year?.description ?? "" {
                // labelと同じ年代のデータを抽出
                mc.delete(salary)
            }
        }
        try! mc.save()
    }
    
}
