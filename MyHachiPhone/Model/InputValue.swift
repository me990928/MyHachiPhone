//
//  InputValue.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

// InputViewのモデル

struct InputValue {
    var startTime: Date
    var endTime: Date
    var breakTime: Double
    var isHoliday: Bool
    var specialWage: Int
    var isSpecialWage: Bool
    var isShiftPlan: Bool
    var isReset: Bool = false
    var isInsert: Bool = false
    var isZero: Bool = false
}
