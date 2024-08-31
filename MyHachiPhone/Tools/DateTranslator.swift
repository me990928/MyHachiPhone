//
//  DateTranslator.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import Foundation

class DateTranslator {
    // Dateを文字列に変換
    func DatetoStringFormatter(date: Date, _ dateFormat: String = "yyyy-MM-dd HH:mm:ss")->String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: date)
    }
    // 文字列をDateに変換
    func StringToDateFormatter(dateString: String, _ dateFormat: String = "yyyy-MM-dd HH:mm:ss")->Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: dateString) else {
            return Date()
        }
        return date
    }
    
    // DateAからDateBを引く
    func dateTimeMinDifference(_ date1: Date, _ date2: Date)->Double {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.hour, .minute], from: date1, to: date2)
        
        if let hour = difference.hour,
           let min = difference.minute {
            return Double(hour) + Double(min) / 60
        } else {
            return Double(0.0)
        }
    }
    
    // 時間を１０進化する
    func hourTransDec(date: Date)->Double {
        let comp = self.dateComponents(date)
        return Double(comp.hour ?? 0 ) + ((Double(comp.minute ?? 0 )) / 60.0)
    }
    
    
    // Dateのコンポーネント化
    func dateComponents(_ date: Date)->DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    }
    
    // 日付配列から最小の値と最大値を返す
    func getLargeAndSmallMonth(dates: [Date])->[Int]{
        
        var large: Int = 0
        var small: Int = 0
        
        for day in dates {
            if dateComponents(day).month ?? 0 > large {
                large = dateComponents(day).month ?? 0
            }
            if dateComponents(day).month ?? 0 < small {
                small = dateComponents(day).month ?? 0
            }
        }
        
        return [large, small]
    }
    
    // 任意の日付を変更する
    func changeDate(date: Date, year: Int)->Date{
        let calendar = Calendar.current
        var dateComp = dateComponents(date)
        dateComp.year = year
        
        if let newDate = calendar.date(from: dateComp){
            return newDate
        }else{
            return Date()
        }
        
    }
    func changeDate(date: Date, month: Int)->Date{
        let calendar = Calendar.current
        var dateComp = dateComponents(date)
        dateComp.month = month
        
        if let newDate = calendar.date(from: dateComp){
            return newDate
        }else{
            return Date()
        }
        
    }
    func changeDate(date: Date, day: Int)->Date{
        let calendar = Calendar.current
        var dateComp = dateComponents(date)
        dateComp.day = day
        
        if let newDate = calendar.date(from: dateComp){
            return newDate
        }else{
            return Date()
        }
        
    }
    func changeDate(date: Date, hour: Int)->Date{
        let calendar = Calendar.current
        var dateComp = dateComponents(date)
        dateComp.hour = hour
        
        if let newDate = calendar.date(from: dateComp){
            return newDate
        }else{
            return Date()
        }
        
    }
    func changeDate(date: Date, min: Int)->Date{
        let calendar = Calendar.current
        var dateComp = dateComponents(date)
        dateComp.minute = min
        
        if let newDate = calendar.date(from: dateComp){
            return newDate
        }else{
            return Date()
        }
        
    }
    func changeDate(date: Date, sec: Int)->Date{
        let calendar = Calendar.current
        var dateComp = dateComponents(date)
        dateComp.second = sec
        
        if let newDate = calendar.date(from: dateComp){
            return newDate
        }else{
            return Date()
        }
        
    }
}
