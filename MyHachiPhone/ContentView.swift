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
    @State var isOpenSettingsView: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
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
                
                VStack(alignment: .trailing){
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButton(isOpen: $isOpenSettingsView)
                            .navigationDestination(isPresented: $isOpenSettingsView) {
                                SettingsView()
                            }
                    }
                }.padding()
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: [SalaryData.self, SalaryTimeData.self, ShiftPlans.self], inMemory: true)
}
