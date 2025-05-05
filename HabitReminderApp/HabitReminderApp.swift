//
//  HabitReminderAppApp.swift
//  HabitReminderApp
//
//  Created by Vikas Soni on 05/05/25.
//

import SwiftUI
import UserNotifications

@main
struct HabitReminderApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            print("Permission granted: \(granted)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
