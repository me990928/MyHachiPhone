//
//  NavContent.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/21.
//

import SwiftUI
import SwiftData

//　SalaryNavからの移動先
struct NavContent: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentation
    
    @Query private var plans: [ShiftPlans]
    
    @State var isPlan: Bool = false
    @State var isDelete: Bool = false
    @State var isRefactor: Bool = false
    
    let data: SalaryData
    let tm: SalaryTimeData
    
    var body: some View {
        VStack(alignment: .leading, content: {
                HStack{
                    Text("\(DateTranslator().DatetoStringFormatter(date: data.startTime, NSLocalizedString("time_format_3", comment: "time format")))").font(.title).bold()
                    Spacer()
                    Button {
                        isDelete.toggle()
                    } label: {
                        Image(systemName: "trash").foregroundStyle(.red)
                    }.buttonStyle(BorderlessButtonStyle())
                        .alert("警告", isPresented: $isDelete) {
                            Button("実行", role: .destructive) {
//                                削除処理
                                self.deleteData()
                            }
                        } message: {
                            Text("削除します")
                        }
                    Button {
//                        時間変更シートフラグ
                        isRefactor.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }.sheet(isPresented: $isRefactor, content: {
                        VStack(alignment: .leading){
                            Text("編集").font(.title)
                            Divider()
                        }.padding()
//                        時間変更シート呼び出し
                        RefactorDataSheet(salaryData: data, modelContext: modelContext).padding().presentationDetents([.large])
                        Spacer()
                            
                    })

                }
                Divider()
            
            Toggle(isOn: $isPlan, label: {
                Text("シフト予定")
            }).onAppear(){
//                表示した時に値をセット
//                値が存在しない場合はfalse
                isPlan = isPlan(plans: plans, id: data.id)
            }.onChange(of: isPlan) {
//                値変更時にセット
//                もしデータがなくてもここで新規セット
                let newModel = ShiftPlans(id: getPlanId(plans: plans, id: data.id), salaryId: data.id, flag: self.isPlan)
                self.modelContext.insert(newModel)
            }
            
                Divider()
                Text("出勤日時：\(DateTranslator().DatetoStringFormatter(date: data.startTime, "yyyy年MM月dd日 HH時mm分"))")
                Text("退勤日時：\(DateTranslator().DatetoStringFormatter(date: data.endTime, "yyyy年MM月dd日 HH時mm分"))")
                Text("休憩時間：\(String(format: "%.2f", data.breakTime))")
//            以下それぞれデータがあれば表示
                data.isHoliday ? Text("休日出勤") : nil
                data.isSpecialWage ? Text("特別時給：\(data.specialWage)") : nil
            
//            時給表示
                Divider()
                let wage = data.isSpecialWage ? data.specialWage : data.isHoliday ? Wage().holidayWage : Wage().baseWage
                Text("時給\(wage)：\(String(format: "%.2f", tm.normalTime))")
                Text("時給\(Int(ceil(Double(wage) * 1.25)))：\(String(format: "%.2f", tm.singleTime))")
                Text("時給\(Int(ceil(Double(wage) * 1.5)))：\(String(format: "%.2f", tm.doubleTime))")
                Divider()
            Text("給料：\(data.salary)").bold()
                Spacer()
            }).padding()
    }
    
    
//    シフト予定の取得
//    給与テーブルのIDをもとに参照
//    初期で見つかった場合はそれを採用して終了
    func isPlan(plans:[ShiftPlans], id: String)->Bool{
        
        if let isPlan = plans.first(where: {$0.salaryId == id}) {
            return isPlan.flag
        } else {
            return false
        }
        
    }
//    シフト予定IDの取得
//    給与テーブルのIDをもとに参照
//    初期で見つかった場合はそれを採用して終了
//    無ければ作成
    func getPlanId(plans:[ShiftPlans], id: String)->String{
        guard let plan = plans.first(where: {$0.salaryId == id})
        else {
            return UUID().uuidString
        }
        return plan.id
    }
    
//    給与テーブルとシフト予定の削除
//    終了時にContentViewへ戻る
    func deleteData(){
        modelContext.delete(data)
        try? modelContext.save()
        deletePlan(planId: getPlanId(plans: plans, id: data.id))
        try? modelContext.save()
        self.presentation.wrappedValue.dismiss()
    }
//    シフト予定の削除
    func deletePlan(planId: String){
        do {
            try modelContext.delete(model: ShiftPlans.self, where: #Predicate { shift in
                shift.id == planId
            })
        } catch {
            print("err")
        }
    }
}

#Preview {
    NavContent(data: SalaryData(id: "", startTime: Date(), endTime: Date(), breakTime: 0.0, isHoliday: false, specialWage: 0, isSpecialWage: false, salary: 0), tm: SalaryTimeData(id: "", salaryId: "", normalTime: 0.0, singleTime: 0.0, doubleTime: 0.0))
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}
