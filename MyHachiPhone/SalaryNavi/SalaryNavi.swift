//
//  SalaryNavi.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/26.
//

import SwiftUI
import SwiftData

/// 日給一覧
struct SalaryNavi: View {
    
    @StateObject var salaryNvVM = SalaryNaviViewModel()
    @Query (sort: \SalaryData.startTime) private var salary: [SalaryData]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(self.salaryNvVM.model.tree, id: \.id){ data in
                SalaryNaviChild(data: data, salary: self.salaryNvVM.model.salaryDict[data.name] ?? [])
            }
        }
        .onAppear() {
            self.salaryNvVM.setSalaryDict(data: salary)
            self.salaryNvVM.setSalaryTree()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}

/// 日給一覧のドロップダウン
struct SalaryNaviChild: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Query private var times: [SalaryTimeData]
    @Query private var plans: [ShiftPlans]
    
    @State var isOpend: Bool = false
    @State var data: SalaryTree
    @State var rotate: Double = 0.0
    @State var salary: [SalaryData]
    
    let currentLocale = Locale.current
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text(keyYeerMonthChange(key: data.name)).font(.title)
                Spacer()
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
            Divider().padding(.bottom)
            
            // yyyy-MMを押した時に開く
            if isOpend {
                VStack(spacing: 0){
                    ForEach(salary, id: \.self){ salaryData in
                        
                        NavigationLink {
                            // リンク
                            NavContent(data: salaryData, tm: times(fillterd: salaryData.id))
                        } label: {
                            // ラベル
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text(DateTranslator().DatetoStringFormatter(date: salaryData.startTime, NSLocalizedString("time_format", comment: "time format")))
                                    Spacer()
                                    Image(systemName: "chevron.right").labelStyle(.iconOnly)
                                }.padding()
                                if salaryData.id != salary.last?.id {
                                    Divider().padding(.horizontal)
                                }
                            }
                        }.frame(maxWidth: .infinity).foregroundStyle(Color(.label))
                    }
                    // ダークテーマなら色を変更する
                }.background(colorScheme == .dark ? Color(.secondarySystemBackground) : .white, in: RoundedRectangle(cornerRadius: 10)).frame(maxWidth: .infinity)
            }
        }
    }
    
    /// 労働時間データから任意のデータを呼び出す
    func times(fillterd: String)->SalaryTimeData{
        let res: SalaryTimeData = SalaryTimeData(id: "", salaryId: "", normalTime: 0.0, singleTime: 0.0, doubleTime: 0.0)
        guard !fillterd.isEmpty else {
            return res
        }
        return times.filter{$0.salaryId.contains(fillterd)}.first ?? res
    }
    ///    英語表記の時にyyyy-MMをMM-yyyynに変換する
    ///    ローカライズで処理しない理由
    ///    英語表記時に以下３つのデータを変換する場合、表示が最後のデータになってしまうための策
    ///    ->data
    ///    2024-04
    ///    2024-05
    ///    2024-06
    ///    ->View
    ///    06-2024
    ///    06-2024
    ///    06-2024
    func keyYeerMonthChange(key: String)->String{
        let splitKey = key.split(separator: "-")
        var res = key
        if currentLocale.language.languageCode != "ja" {
            res = String(splitKey.last ?? "") + "-" + String(splitKey.first ?? "")
        }
        return res
    }
}
