//
//  NewLetterView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import SwiftUI

struct NewLetterView: View {

    @Environment(\.dismiss) var dismiss
    
    @Binding var path: NavigationPath

    @State private var name = ""
    @State private var profession = ""
    @State private var goal = ""
    @State private var targetDate: Date = {
        return Calendar.current.date(byAdding: .year, value: 40, to: Date()) ?? Date()
    }()

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Profession", text: $profession)
            }

            Section {
                ZStack(alignment: .topLeading) {
                    if goal.isEmpty {
                        Text("Write your goals, dreams, and feelings here...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }

                    TextEditor(text: $goal)
                        .frame(minHeight: 120)
                }
            }

            Section {
                DatePicker("Future Date", selection: $targetDate, displayedComponents: .date)
            }
        }
        .navigationTitle("New Letter")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    // 3. Create the Letter Object
                    let newLetter = Letter(
                        name: name,
                        profession: profession,
                        goal: goal,
                        targetDate: targetDate,
                        createdAt: Date(),
                        letter: goal // Pass the goal as the letter content
                    )
                    
                    // 4. Dismiss the Sheet
                    dismiss()
                    
                    // 5. Append to Path (Logic: Close Sheet -> Wait -> Push View)
                    // This delay ensures the sheet is fully closed before the push animation starts
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        path.append(newLetter)
                    }
                }
            }
        }
    }
}
