//
//  SalaryNaviViewModel.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/26.
//

import Foundation
import SwiftData

class SalaryNaviViewModel: ObservableObject {
    @Published var model = SalaryNaviModel()
    
    // mdoelの辞書に値をセット
    func setSalaryDict(data: [SalaryData]){
        self.model.salaryDict = MonthlySalary().groupByMonth(salaryData: data)
    }
    
    // ツリー
//    ドロップダウンのタイトルとリストを結ぶ配列
    func setSalaryTree() {
        self.model.tree = [] // ツリーを初期化
        
        for key in self.model.salaryDict.keys.sorted() {
            var children: [String] = [] // 空の配列として初期化
            
            for data in self.model.salaryDict[key] ?? [] {
                let formattedDate = DateTranslator().DatetoStringFormatter(date: data.startTime, "yyyy年MM月dd日 HH時mm分 出勤")
                children.append(formattedDate)
            }
            
            let treeTemp = SalaryTree(id: UUID().uuidString, name: key, children: children)
            self.model.tree.append(treeTemp)
        }
    }
}
