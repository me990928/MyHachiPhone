//
//  WorkTimes.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

/// 労働時間モデル
struct WorkTimes {
    var startTimeHour: Double = 0.0     // 労働開始時間
    var endTimeHour: Double = 0.0       // 労働終了時間
    var dayWorkTime: Double = 0.0       // 日勤労働時間
    var nightWorkTime: Double = 0.0     // 夜勤労働時間
    var workTime: Double = 0.0          // 総労働時間
}
