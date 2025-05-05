//
//  ContentView.swift
//  HabitReminderApp
//
//  Created by Vikas Soni on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: HabitViewModel
    @State private var showingAddHabit = false

    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(wrappedValue: HabitViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.habits, id: \.self) { habit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habit.title ?? "Unnamed")
                                .font(.headline)
                            if let time = habit.time {
                                Text(time, style: .time)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Toggle("", isOn: Binding(
                            get: { habit.isEnabled },
                            set: { _ in viewModel.toggleHabit(habit) }
                        ))
                        .labelsHidden()
                    }
                }
            }
            .navigationTitle("Daily Habits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddHabit = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(viewModel: viewModel)
            }
        }
    }
}
