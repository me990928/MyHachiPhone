//
//  ContentView.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/21.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query (sort: \SalaryData.startTime) private var salary: [SalaryData]
    @Query private var times: [SalaryTimeData]
    
    @State var isOpenTopView: Bool = false
    @State var path: NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
                VStack{
                    List {
                            Section(content: {
                                NavigationLink("入力画面"){
                                    ScrollView (showsIndicators: false) {
                                        InputView().navigationTitle("入力画面").padding()
                                    }
                                }
                                NavigationLink("月間別給料"){
                                    ScrollView(showsIndicators: false){
                                        VStack{
                                            MonthView().navigationTitle("月間別給料")
                                            Spacer().frame(height: 300)
                                        }
                                    }.padding()
                                }
                                
                            }, header: {
                                    Text("Menu")
                            })
                    }
                    
                    .navigationDestination(isPresented: $isOpenTopView) {
                        ContentView()
                    }.frame(maxHeight: 150)
                    
                    ScrollView{
                        Section {
                            SalaryNavi().padding()
                        } header: {
                            HStack{
                                Text("日給一覧").foregroundStyle(.secondary)
                                Spacer()
                            }.padding(.leading).listRowInsets(EdgeInsets())
                        }
                        Spacer()
                    }
                }.background(colorScheme == .light ? Color(.secondarySystemBackground) : .clear)
        }
    }
    
    
    func times(fillterd: String)->SalaryTimeData{
        let res: SalaryTimeData = SalaryTimeData(id: "", salaryId: "", normalTime: 0.0, singleTime: 0.0, doubleTime: 0.0)
        guard !fillterd.isEmpty else {
            return res
        }
        return times.filter{$0.salaryId.contains(fillterd)}.first ?? res
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}
