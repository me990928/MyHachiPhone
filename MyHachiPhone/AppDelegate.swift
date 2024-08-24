//
//  AppDelegate.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/18.
//
import Foundation
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in // optionsには通知の種類を指定
            if let error {
                // 通知が拒否された場合
                print(error.localizedDescription)
            }
        }
        
        return true
    }
}
