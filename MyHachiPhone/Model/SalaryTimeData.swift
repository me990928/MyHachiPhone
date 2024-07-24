//
//  SalaryTimeData.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/10.
//

import Foundation
import SwiftData

// 労働時間のテーブル

@Model
final class SalaryTimeData {
    @Attribute(.unique) var id: String
    var salaryId: String
    var normalTime: Double
    var singleTime: Double
    var doubleTime: Double
    
    init(id: String, salaryId: String, normalTime: Double, singleTime: Double, doubleTime: Double) {
        self.id = id
        self.salaryId = salaryId
        self.normalTime = normalTime
        self.singleTime = singleTime
        self.doubleTime = doubleTime
    }
}
