//
//  ShiftPlans.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/06/01.
//

import Foundation
import SwiftData

// シフト予定モデル
//　シフトが予定なのか実際に仕事したデータかの判断に使用

@Model
final class ShiftPlans: Identifiable {
    @Attribute(.unique) var id: String
    var salaryId: String
    var flag: Bool
    
    init(id: String, salaryId: String, flag: Bool) {
        self.id = id
        self.salaryId = salaryId
        self.flag = flag
    }
}
