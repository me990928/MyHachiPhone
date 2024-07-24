//
//  MyHachiPhoneApp.swift
//  MyHachiPhone
//
//  Created by 広瀬友哉 on 2024/05/21.
//

import SwiftUI
import SwiftData

@main
struct MyHachiPhoneApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SalaryData.self,
            SalaryTimeData.self,
            ShiftPlans.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
