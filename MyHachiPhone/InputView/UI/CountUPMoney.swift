//
//  CountUPMoney.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//
import SwiftUI
/// 特別給与設定を変更するUI
struct countUPManey: View {
    
    @Binding var value: Int
    
    var body: some View {
        VStack(alignment: .leading){
            Text("特別時給：\(value)")
            Grid{
                GridRow {
                    Button(action: {
                        value += 1000
                    }, label: {
                        Text("+1000").frame(width: 50)
                    })
                    Button(action: {
                        value += 100
                    }, label: {
                        Text("+100").frame(width: 50)
                    })
                    Button(action: {
                        value += 10
                    }, label: {
                        Text("+10").frame(width: 50)
                    })
                    Button(action: {
                        value += 1
                    }, label: {
                        Text("1").frame(width: 50)
                    })
                }
                Divider().gridCellUnsizedAxes(.horizontal)
                GridRow {
                    Button(action: {
                        value -= 1000
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-1000").frame(width: 50)
                    })
                    Button(action: {
                        value -= 100
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-100").frame(width: 50)
                    })
                    Button(action: {
                        value -= 10
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-10").frame(width: 50)
                    })
                    Button(action: {
                        value -= 1
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-1").frame(width: 50)
                    })
                }
            }
        }
    }
}
