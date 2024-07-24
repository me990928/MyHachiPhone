//
//  WorkFlag.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation
// parameters
//　給与計算のパラメータ群
struct WorkParameters {
    var isNightWork: Bool = false   // 夜勤の有無
    var isOverWork: Bool = false    // 残業の有無
    var is22UnderOverWork: Bool = false // 22時前の残業の有無
    let normalWork: Double = 8.0    // 法廷内労働時間
    let nightWorkStartTime: Double = 22.0   // 残業開始時間
    let singleMultiplier: Double = 1.25     // １回目の倍率
    let doubleMultiplier: Double = 1.5      // 2回目の倍率
}
