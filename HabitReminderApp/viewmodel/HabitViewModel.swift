//
//  HabitViewModel.swift
//  HabitReminderApp
//
//  Created by Vikas Soni on 05/05/25.
//

import Foundation
import CoreData
import UserNotifications

class HabitViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    @Published var habits: [HabitEntity] = []

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchHabits()
    }

    func fetchHabits() {
        let request: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \HabitEntity.time, ascending: true)]

        do {
            habits = try context.fetch(request)
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

    func addHabit(title: String, time: Date) {
        let habit = HabitEntity(context: context)
        habit.id = UUID()
        habit.title = title
        habit.time = time
        habit.isEnabled = true
        save()
        scheduleNotification(for: habit)
    }

    func toggleHabit(_ habit: HabitEntity) {
        habit.isEnabled.toggle()
        save()

        if habit.isEnabled {
            scheduleNotification(for: habit)
        } else {
            removeNotification(for: habit)
        }
    }

    func save() {
        do {
            try context.save()
            fetchHabits()
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }

    func scheduleNotification(for habit: HabitEntity) {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = habit.title ?? "Your habit"
        content.sound = .default

        let triggerTime = habit.time ?? Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: triggerTime)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(
            identifier: habit.id?.uuidString ?? UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func removeNotification(for habit: HabitEntity) {
        guard let id = habit.id?.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
