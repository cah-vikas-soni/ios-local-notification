//
//  HabitReminderAppApp.swift
//  HabitReminderApp
//
//  Created by Vikas Soni on 05/05/25.
//

import SwiftUI

@main
struct HabitReminderAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
