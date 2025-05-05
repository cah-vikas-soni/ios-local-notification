//
//  AddHabitView.swift
//  HabitReminderApp
//
//  Created by Vikas Soni on 05/05/25.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: HabitViewModel

    @State private var title: String = ""
    @State private var time: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Name", text: $title)
                DatePicker("Reminder Time", selection: $time, displayedComponents: .hourAndMinute)
            }
            .navigationTitle("Add Habit")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addHabit(title: title, time: time)
                        presentationMode.wrappedValue.dismiss()
                    }.disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
