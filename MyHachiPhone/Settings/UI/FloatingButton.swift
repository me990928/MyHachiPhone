//
//  FloatingButton.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI

struct FloatingButton: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Circle().frame(width: 70)
                Image(systemName: "gearshape.fill").font(.title).foregroundStyle(.white).padding()
            }
        }
    }
}

#Preview {
    FloatingButton()
}
