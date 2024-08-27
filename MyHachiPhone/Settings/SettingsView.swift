//
//  SettingsView.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI

struct SettingsView: View {
    
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
        VStack {
            HStack {
                if edit {
                    Button("キャンセル", role: .cancel) {
                        withAnimation {
                            edit.toggle()
                        }
                    }.padding(.leading)
                }
                Spacer()
                Button(action: {
                    if edit {
                        SettingVM.editTeate(teate: teate)
                        if !wage.isEmpty {
                            SettingVM.editWage(wage: wage){
                                wagePlaceholder = UserDefaults().string(forKey: "wage") ?? "1100"
                                withAnimation {
                                    wage = ""
                                }
                            }
                        }
                        withAnimation {
                            edit.toggle()
                        }
                    } else {
                        withAnimation {
                            edit.toggle()
                        }
                    }
                }, label: {
                    
                    Text(edit ? "保存" : "編集")
                    
                }).buttonStyle(BorderedProminentButtonStyle())
                
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            List {
                HStack{
                    Text("時給")
                    Spacer()
                    TextField(wagePlaceholder, text: $wage).multilineTextAlignment(.trailing).keyboardType(.decimalPad)
                    Text("円")
                }
                HStack{
                    Toggle("手当なし計算", isOn: $teate)
                }
            }.disabled(!edit)
        }.background(colorScheme == .light ? Color(.secondarySystemBackground) : .clear)
    }
}

#Preview {
    SettingsView()
}
