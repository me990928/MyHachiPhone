//
//  YearSalaryDeleteView.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI
import SwiftData

struct YearSalaryDeleteView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var plans: [ShiftPlans]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    YearSalaryDeleteView()
}
