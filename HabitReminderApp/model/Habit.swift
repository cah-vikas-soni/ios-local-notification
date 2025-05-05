//
//  Habit.swift
//  HabitReminderApp
//
//  Created by Vikas Soni on 05/05/25.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var title: String
    var time: Date
    var isEnabled: Bool
}
