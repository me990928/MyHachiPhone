//
//  InputView.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import SwiftUI
import SwiftData

/// 入力画面
struct InputView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var salary: [SalaryData]
    @Query private var shift: [ShiftPlans]
    @StateObject var input = InputViewModel()
    
    var body: some View {
        
        VStack{
            HStack{
                VStack{
                    DatePicker("勤務開始時間", selection: $input.model.startTime).onChange(of:  DateTranslator().DatetoStringFormatter(date: input.model.startTime, "dd")) { oldValue, newValue in
                        input.model.endTime = DateTranslator().changeDate(date: input.model.endTime, day: Int(newValue) ?? 1)
                    }.onAppear(){
                        // 呼び出し時に初期値を設定
                        // 開始時間：現在時間の00分
                        // 終了時間：23時00分
                        input.model.startTime = DateTranslator().changeDate(date: Date(), min: 0)
                        input.model.endTime = DateTranslator().changeDate(date: Date(), min: 0)
                        input.model.endTime = DateTranslator().changeDate(date: input.model.endTime, hour: 23)
                    }.onChange(of:  DateTranslator().DatetoStringFormatter(date: input.model.startTime, "MM")) { oldValue, newValue in
                        // 開始月を変更した時に終了月を同じ時間にする
                        input.model.endTime = DateTranslator().changeDate(date: input.model.endTime, month: Int(newValue) ?? 1)
                    }.onChange(of:  DateTranslator().DatetoStringFormatter(date: input.model.startTime, "yyyy")) { oldValue, newValue in
                        // 開始年を変更した時に終了年を同じ時間にする
                        input.model.endTime = DateTranslator().changeDate(date: input.model.endTime, year: Int(newValue) ?? 2000)
                    }
                    DatePicker("勤務終了時間", selection: $input.model.endTime)
                }
                Spacer()
            }
            Divider()
            
            HStack{
                Toggle("シフト予定", isOn: $input.model.isShiftPlan)
                Spacer()
            }
            
            Divider()
            
            HStack{
                Toggle("休日勤務", isOn: $input.model.isHoliday)
                Spacer()
            }
            
            Divider()
            
            HStack{
                CountUPState(value: $input.model.breakTime)
                Spacer()
            }
            Divider()
            VStack{
                HStack{
                    // フラグがTrueの時にUIを有効
                    Toggle("特別時給", isOn: $input.model.isSpecialWage).onChange(of: input.model.isSpecialWage) {
                        if !input.model.isSpecialWage {
                            input.model.specialWage = 0
                        }
                    }
                    Spacer()
                }
                HStack{
                    countUPManey(value: $input.model.specialWage).disabled(!input.model.isSpecialWage)
                    Spacer()
                }
            }
            HStack{
                
                Button(action: {
                    // 計算メソッド
                    input.salary = input.getSalary().salary
                }, label: {
                    Text("計算開始")
                }).padding()
                
                Button(action: {
                    if input.salary == 0 {
                        // 計算結果が0なら警告を鳴らす
                        input.model.isZero.toggle()
                        return
                    }
                    // フラグ操作１
                    input.model.isInsert.toggle()
                }, label: {
                    Text("登録")
                }).padding()
                
                Button(action: {
                    // フラグ操作２
                    input.model.isReset.toggle()
                }, label: {
                    Text("リセット").foregroundStyle(.red)
                }).padding()
                // フラグ操作結果１
                    .alert("登録",isPresented: $input.model.isInsert){
                        Button("戻る", role: .cancel){
                        }
                        Button("実行"){
                            self.insertData()
                            input.sendShiftLoaclPush()
                        }
                        
                    } message: {
                        Text("入力内容を登録します")
                    }
                // フラグ操作結果２
                    .alert("警告",isPresented: $input.model.isReset){
                        Button("リセット", role: .destructive){
                            self.inputReset()
                        }
                        
                    } message: {
                        Text("入力内容をリセットします")
                    }
                // 計算結果０警告
                    .alert("警告",isPresented: $input.model.isZero){
                        Button("実行", role: .destructive){
                            self.insertData()
                            input.sendShiftLoaclPush()
                        }
                        
                    } message: {
                        Text("計算を実行していません")
                    }
                
                Spacer()
            }
            
            HStack{
                Spacer()
                Text("給料：\(input.salary)円").font(.title).bold()
            }
        }
    }
    
    /// 入力内容リセット
    private func inputReset(){
        let startTime =  DateTranslator().changeDate(date: Date(), min: 0)
        var endTime = DateTranslator().changeDate(date: Date(), min: 0)
        endTime = DateTranslator().changeDate(date: endTime, hour: 23)
        
        input.model = InputValue(startTime: startTime, endTime: endTime, breakTime: 0.0, isHoliday: false, specialWage: 0, isSpecialWage: false, isShiftPlan: input.model.isShiftPlan)
    }
    /// 入力内容を登録
    private func insertData(){
        
        let salaryId = UUID().uuidString
        
        let newModel = SalaryData(id: salaryId, startTime: input.model.startTime, endTime: input.model.endTime, breakTime: ceil(input.model.breakTime * 100) / 100, isHoliday: input.model.isHoliday, specialWage: input.model.specialWage, isSpecialWage: input.model.isSpecialWage, salary: input.salary)
        modelContext.insert(newModel)
        
        WorkTime(modelContext: modelContext, times: input.getSalary().times).insertModel(newModel)
        
        let newModel2 = ShiftPlans(id: UUID().uuidString, salaryId: salaryId, flag: input.model.isShiftPlan)
        
        modelContext.insert(newModel2)
        
    }
}

#Preview {
    InputView()
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}
