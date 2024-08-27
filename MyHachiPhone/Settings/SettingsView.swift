//
//  SettingsView.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var edit: Bool = false
    
    @State var wage: String = ""
    let wagePlaceholder: String
    @AppStorage ("teate") var teate: Bool = false
    
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
                    withAnimation {
                        edit.toggle()
                    }
                }, label: {
                    Text(edit ? "保存" : "編集")
                }).buttonStyle(BorderedProminentButtonStyle())
            }.padding(.trailing)
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
    SettingsView(wagePlaceholder: "1100")
}
