//
//  FloatingButton.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var isOpen: Bool
    var body: some View {
        Button {
            isOpen.toggle()
        } label: {
            ZStack {
                Circle().frame(width: 70)
                Image(systemName: "gearshape.fill").font(.title).foregroundStyle(.white).padding()
            }
        }
    }
}
