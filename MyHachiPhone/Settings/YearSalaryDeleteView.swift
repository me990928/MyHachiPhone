//
//  YearSalaryDeleteView.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/08/28.
//

import SwiftUI
import SwiftData

struct YearSalaryDeleteView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isAlert: Bool = false
    @State var isView: Bool = true
    @State var label: String = ""
    @State var height: CGFloat = 0
    @State var rowCount: Int = 0
    var yearSalaryDeleteModel: YearsSalaryDeleteModel
    
    var body: some View {
        ZStack{
            if isView {
                VStack{
                    VStack(alignment: .leading){
                        ForEach(yearSalaryDeleteModel.yearList, id: \.self) { year in
                            ListChild(rowCount: $rowCount, text: year, last: yearSalaryDeleteModel.yearList.last == year)
                        }
                    }.padding()
                        .onAppear(){
                            if rowCount == 0 {
                                isView = false
                            }
                        }
                        .onChange(of: rowCount) {
                        if rowCount == 0 {
                            withAnimation {
                                isView = false
                            }
                        }
                    }
                    HStack{Spacer()}
                }.background(colorScheme == .light ? Color(.systemGray5) : Color(.systemGray2)).clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
        }.padding().onAppear(){
            rowCount = yearSalaryDeleteModel.yearList.count
        }
    }
    
}

#Preview {
    YearSalaryDeleteView(yearSalaryDeleteModel: .init(salary: []))
}

struct ListChild: View {
    
    @Binding var rowCount: Int
    
    @State var isAlert: Bool = false
    @State var label: String = ""
    @State var isDelete: Bool = false
    
    let text: String
    let last: Bool
    
    var body: some View {
        if !isDelete {
            Button(action: {
                label = text
                isAlert.toggle()
            }, label: {
                VStack{
                    HStack{
                        Text(text).foregroundStyle(Color(.label))
                        Spacer()
                    }.padding(.leading)
                    if !last {
                        Divider().background(Color(.label))
                    }
                }
            })
            .transition(.slide)
            .alert("警告", isPresented: $isAlert) {
                Button("戻る", role: .cancel){
                    
                }
                Button("削除", role: .destructive) {
                    rowCount -= 1
                    withAnimation {
                        isDelete.toggle()
                    }
                }
            } message: {
                Text("\(label)年のデータを削除します。")
            }
        }
    }
}
