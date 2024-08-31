//
//  SettingsView.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query (sort: \SalaryData.startTime) private var salary: [SalaryData]
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var SettingVM = SettingsViewModel()
    
    @State var edit: Bool = false
    
    @State var wage: String = ""
    @State var wagePlaceholder: String
    @State var teate: Bool
    
    init(){
        self.wagePlaceholder = UserDefaultsMan().loadUserDefaultString(key: "wage")
        self.teate = UserDefaultsMan().loadUserDefaultBool(key: "teate")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    if edit {
                        Button("キャンセル", role: .cancel) {
                            edit.toggle()
                        }.padding(.leading)
                    }
                    Spacer()
                    Button(action: {
                        if edit {
                            SettingVM.editTeate(teate: teate)
                            if !wage.isEmpty {
                                SettingVM.editWage(wage: wage){
                                    wagePlaceholder = UserDefaults().string(forKey: "wage") ?? "1100"
                                    wage = ""
                                }
                            }
                            edit.toggle()
                        } else {
                            edit.toggle()
                        }
                    }, label: {
                        
                        Text(edit ? "保存" : "編集")
                        
                    })
                    
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                List {
                    HStack{
                        Text("時給")
                        Spacer()
                        TextField(wagePlaceholder, text: $wage).multilineTextAlignment(.trailing).keyboardType(.decimalPad)
                        Text("円")
                    }.disabled(!edit)
                    HStack{
                        Toggle("手当なし計算", isOn: $teate)
                    }.disabled(!edit)
                    NavigationLink("年代別削除") {
                        YearSalaryDeleteView(yearSalaryDeleteModel: .init(salary: salary))
                    }
                }
            }.background(colorScheme == .light ? Color(.secondarySystemBackground) : .clear)
        }
    }
}

#Preview {
    SettingsView()
}
