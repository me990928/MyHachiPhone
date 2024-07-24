//
//  RefactorDateTime.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/06/02.
//

import SwiftUI
import SwiftData

// 給与テーブルのデータを変更するページ
// InputViewの再利用
struct RefactorDataSheet: View {
    
    @Environment(\.presentationMode) var presentation
    @StateObject var input = InputViewModel()
    
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    
    @State var isRefactor: Bool = false
    
    @State var salaryData: SalaryData
    @State var modelContext: ModelContext
    
    var body: some View {
        
        VStack{
            HStack{
                VStack{
                    DatePicker("勤務開始時間", selection: $input.model.startTime).onChange(of:  DateTranslator().DatetoStringFormatter(date: input.model.startTime, "dd")) { oldValue, newValue in
                        input.model.endTime = DateTranslator().changeDate(date: input.model.endTime, day: Int(newValue) ?? 1)
                    }
                    DatePicker("勤務終了時間", selection: $input.model.endTime)
                }
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
//                        フラグがTrueの時にUIを有効
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
//                        計算メソッド
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
//                        フラグ操作１
                    input.model.isInsert.toggle()
                }, label: {
                    Text("登録")
                }).padding()
                
                Button(action: {
//                        フラグ操作２
                    input.model.isReset.toggle()
                }, label: {
                    Text("リセット").foregroundStyle(.red)
                }).padding()
                
    //                    フラグ操作結果１
                    .alert("登録",isPresented: $input.model.isInsert){
                        Button("戻る", role: .cancel){
                        }
                        Button("実行"){
                            self.insertData()
                        }
                        
                    } message: {
                        Text("入力内容を登録します")
                    }
    //                    フラグ操作結果２
                    .alert("警告",isPresented: $input.model.isReset){
                        Button("リセット", role: .destructive){
                            self.inputReset()
                        }
                        
                    } message: {
                        Text("入力内容をリセットします")
                    }
//                    計算結果０警告
                    .alert("警告",isPresented: $input.model.isZero){
                        Button("実行", role: .destructive){
                            self.insertData()
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
        }.onAppear(){
            inputReset()
        }
    }

////    入力内容リセット
    private func inputReset(){
        
        input.model = InputValue(startTime: salaryData.startTime, endTime: salaryData.endTime, breakTime: salaryData.breakTime, isHoliday: salaryData.isHoliday, specialWage: salaryData.specialWage, isSpecialWage: salaryData.isSpecialWage, isShiftPlan: input.model.isShiftPlan)
    }
//    入力内容を登録
    private func insertData(){
        
        let newModel = SalaryData(id: salaryData.id, startTime: input.model.startTime, endTime: input.model.endTime, breakTime: ceil(input.model.breakTime * 100) / 100, isHoliday: input.model.isHoliday, specialWage: input.model.specialWage, isSpecialWage: input.model.isSpecialWage, salary: input.salary)
        modelContext.insert(newModel)
        
        WorkTime(modelContext: modelContext, times: input.getSalary().times).refactorModel(newModel)
        
        self.presentation.wrappedValue.dismiss()
        
    }
    
}

#Preview {
    NavContent(data: SalaryData(id: "", startTime: Date(), endTime: Date(), breakTime: 0.0, isHoliday: false, specialWage: 0, isSpecialWage: false, salary: 0), tm: SalaryTimeData(id: "", salaryId: "", normalTime: 0.0, singleTime: 0.0, doubleTime: 0.0))
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}
