//
//  CountUPState.swift
//  HachiCal
//
//  Created by 広瀬友哉 on 2024/05/08.
//

import SwiftUI
// 休憩時間のカウントを上下させるUI
struct CountUPState<T>: View where T: BinaryFloatingPoint {
    
    @Binding var value: T
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(NSLocalizedString("休憩時間", comment: "break time"))：\((ceil(value * 100) / 100))")
            Grid{
                GridRow {
                    Button(action: {
                        value += 1
                    }, label: {
                        Text("+1").frame(width: 50)
                    })
                    Button(action: {
                        value += 0.5
                    }, label: {
                        Text("+0.5").frame(width: 50)
                    })
                    Button(action: {
                        value += 0.1
                    }, label: {
                        Text("+0.1").frame(width: 50)
                    })
                    Button(action: {
                        value += 0.01
                    }, label: {
                        Text("+0.01").frame(width: 50)
                    })
                }
                Divider().gridCellUnsizedAxes(.horizontal)
                GridRow {
                    Button(action: {
                        value -= 1
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-1").frame(width: 50)
                    })
                    Button(action: {
                        value -= 0.5
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-0.5").frame(width: 50)
                    })
                    Button(action: {
                        value -= 0.1
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-0.1").frame(width: 50)
                    })
                    Button(action: {
                        value -= 0.01
                        if (value < 0) { value = 0 }
                    }, label: {
                        Text("-0.01").frame(width: 50)
                    })
                }
            }
        }
    }
}
