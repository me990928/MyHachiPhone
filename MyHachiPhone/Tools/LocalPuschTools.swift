//
//  LocalPuschTools.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/18.
//

import Foundation
import UserNotifications

final class LocalPuschTools {
    
    // 通知の送信
    func sendLocalPush(dateComp: DateComponents){
        
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = NSLocalizedString("お疲れ様です。\n終了時間が予定と合っているか確認しよう。", comment: "local push message.")
        content.sound = .default
        
        if let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            content.title = appDisplayName
        } else if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            content.title = appName
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request)
    }
    
}
