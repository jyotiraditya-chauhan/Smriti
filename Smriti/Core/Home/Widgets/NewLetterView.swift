//
//  NewLetterView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//



import SwiftUI
import _SwiftData_SwiftUI
import FoundationModels

struct NewLetterView: View {

    @Environment(\.dismiss) var dismiss
    @Binding var path: NavigationPath
    private let viewModel = HomeViewModel()
    @Environment(\.modelContext) private var context

    @State private var name = ""
    @State private var profession = ""
    @State private var goal = ""
    @State private var targetDate: Date = {
        Calendar.current.date(byAdding: .year, value: 20, to: Date()) ?? Date()
    }()

    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .textContentType(.name)
                    .autocorrectionDisabled()

                TextField("Profession", text: $profession)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .textContentType(.jobTitle)
            } footer: {
                if hasEmoji(name) || hasEmoji(profession) {
                    Text("Emojis are not allowed in these fields.")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }

            Section {
                ZStack(alignment: .topLeading) {
                    if goal.isEmpty {
                        Text("Write your goals, dreams, and feelings here...")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }

                    TextEditor(text: $goal)
                        .frame(minHeight: 120)
                }
            } footer: {
                if hasEmoji(goal) {
                    Text("Please describe your goals using text only (no emojis).")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }

            Section {
                DatePicker(
                    "Future Date",
                    selection: $targetDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .font(.system(size: 18, weight: .medium, design: .rounded))
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Generate Letter")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .tint(.white)
                .disabled(isLoading)
            }

            ToolbarItem(placement: .confirmationAction) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Button("Done") {
                        attemptCreation()
                    }
                    .tint(.white)
                    .opacity(isValidForm ? 1.0 : 0.5)
                }
            }
        }
    
        .alert("Input Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isValidForm: Bool {
        !name.isEmpty &&
        !profession.isEmpty &&
        !hasEmoji(name) &&
        !hasEmoji(profession) &&
        !hasEmoji(goal)
    }

    private func attemptCreation() {
    
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter your name."
            showAlert = true
            return
        }
        
        guard !profession.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter your profession."
            showAlert = true
            return
        }
        
        if hasEmoji(name) || hasEmoji(profession) || hasEmoji(goal) {
            alertMessage = "Please remove emojis from all fields. We want this letter to be strictly text-based."
            showAlert = true
            return
        }
        
        createLetter()
    }
    
    private func hasEmoji(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            if scalar.properties.isEmoji && scalar.properties.isEmojiPresentation {
                return true
            }
        }
        return false
    }

    private func createLetter() {
        isLoading = true
        
        Task {
            do {
                let generatedLetter = try await viewModel.getLetter(
                    name: name,
                    profession: profession,
                    goal: goal,
                    date: targetDate
                )

                let newLetter = Letter(
                    name: name,
                    profession: profession,
                    goal: goal,
                    targetDate: targetDate,
                    createdAt: Date(),
                    letter: generatedLetter,
                    locked: true
                )

                await MainActor.run {
                    context.insert(newLetter)
                    isLoading = false
                    dismiss()
                }

            } catch {
                print("Failed to generate letter:", error)
                await MainActor.run {
                    isLoading = false
                    alertMessage = "Failed to generate letter. Please try again."
                    showAlert = true
                }
            }
        }
    }
}
