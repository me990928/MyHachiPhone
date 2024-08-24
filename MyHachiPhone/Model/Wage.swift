//
//  Wage.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

/// 給与モデル
struct Wage {
    var baseWage: Int = 1100
    var holidayWage: Int = 1150
    var wage: Int = 0   // この値が倍率を含めた実際の時給になる
}
