//
//  MonthView.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/15.
//

import SwiftUI
import SwiftData

// 月間の給与を一覧表示

struct MonthView: View {
    
    @Query(sort: \SalaryData.startTime) private var salary: [SalaryData]
    @StateObject var monthVM = MonthViewModel()
    
    @State var isOpend: Bool = false
    
    var body: some View {
            VStack(alignment: .leading){
                ForEach(monthVM.model.monthDict.keys.sorted(), id: \.self){ key in
                    MonthSectionView(monthVM: monthVM, key: key)
                }
            }.onAppear(){
//                月毎のSalaryDataを出勤日時を”yyyy-MM”にした文字型で辞書化
                monthVM.model.monthDict = monthVM.groupByMonth(salaryData: salary)
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}

struct MonthSectionView: View {
    
    @State var isOpend: Bool = false
    @ObservedObject var monthVM: MonthViewModel
    @State var key: String
    @State var headerDate: Date = Date()
    
    @State var rotate: Double = 0.0
    
    
    @Query private var plans: [ShiftPlans]
    
    let currentLocale = Locale.current
    
    var body: some View {
//            ドロップダウン
            Section(isExpanded: $isOpend ) {
                
                ForEach(monthVM.model.monthDict[key] ?? []) { dict in
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(DateTranslator().DatetoStringFormatter(date: dict.startTime, NSLocalizedString("time_format", comment: "time format"))) 出勤").padding(.top, 5)
                            Spacer()
                            if isPlan(plans: plans, id: dict.id) {
                                Text("予定").foregroundStyle(.red)
                            }
                        }
                        Text("\(DateTranslator().DatetoStringFormatter(date: dict.endTime,  NSLocalizedString("time_format", comment: "time format"))) 退勤")
                        Text("休憩：\(String(format: "%.2f", dict.breakTime))")
                        Text("時給：\(dict.isSpecialWage ? Int(dict.specialWage) : dict.isHoliday ? Int(1150) : Int(1100))")
                        Text("給料：\(dict.salary)")
                    }
                    
                }
                Divider()
            } header: {
//                ラベル
                VStack(alignment: .leading){
                    Text(keyYeerMonthChange(key: key)).font(.title2).foregroundStyle(.secondary)
                    HStack{
                        Text("合計：\(monthVM.monthlySalary(dict: monthVM.model.monthDict , key: key))").font(.title).bold()
                        Spacer()
//                        ダウンフラグ操作
                        Button {
                            withAnimation(){
                                isOpend.toggle()
                                if isOpend {
                                    rotate = 180.0
                                } else {
                                    rotate = 0.0
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.up").rotationEffect(Angle(degrees: rotate))
                        }.buttonStyle(BorderlessButtonStyle())

                    }
                    Divider()
                }
            }.transition(.opacity)
        }
    //    英語表記の時にyyyy-MMをMM-yyyynに変換する
    //    ローカライズで処理しない理由
    //    英語表記時に以下３つのデータを変換する場合、表示が最後のデータになってしまうための策
    //    ->data
    //    2024-04
    //    2024-05
    //    2024-06
    //    ->View
    //    06-2024
    //    06-2024
    //    06-2024
    func keyYeerMonthChange(key: String)->String{
        let splitKey = key.split(separator: "-")
        var res = key
        if currentLocale.language.languageCode != "ja" {
            res = String(splitKey.last ?? "") + "-" + String(splitKey.first ?? "")
        }
        return res
    }
    //    シフト予定の取得
    //    給与テーブルのIDをもとに参照
    //    初期で見つかった場合はそれを採用して終了
    func isPlan(plans:[ShiftPlans], id: String)->Bool{
        if let plan = plans.first(where: { plan in
            plan.salaryId == id
        }) {
            return plan.flag
        } else {
            return false
        }
    }
}


