//
//  SalaryNaviModel.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/26.
//

import Foundation

struct SalaryNaviModel {
    var salaryDict: [String: [SalaryData]] = [String: [SalaryData]]()
    var tree: [SalaryTree] = [] // 空の配列として初期化
    
    let test: [SalaryTree] = [
        SalaryTree(id: UUID().uuidString, name: "data1", children: [
            "data1-1", "data1-2"
        ]),
        
        SalaryTree(id: UUID().uuidString, name: "data2", children: [
            "data2-1", "data2-2"
        ]),
    
        SalaryTree(id: UUID().uuidString, name: "data3", children: [
            "data3-1", "data3-2"
        ])
    ]
}

struct SalaryTree: Identifiable {
    var id: String
    var name: String
    var children: [String]? = nil // オプショナルとして定義
}


