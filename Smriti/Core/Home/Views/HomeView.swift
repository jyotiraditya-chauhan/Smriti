//
//  HomeView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 19/01/26.
//
import SwiftUI

struct HomeView: View {
    
    let letters = [
        Letter(
            name: "Aditya Chauhan",
            profession: "iOS Developer",
            goal: "I hope you are doing well and have finally built that dream app...",
            targetDate: Calendar.current.date(byAdding: .year, value: 20, to: Date())!,
            createdAt: Date(),
            letter: nil
        ),
        Letter(
            name: "Aditya Chauhan",
            profession: "Junior Designer",
            goal: "Remember why you started: to make technology accessible...",
            targetDate: Calendar.current.date(byAdding: .year, value: 5, to: Date())!,
            createdAt: Date().addingTimeInterval(-86400 * 3),
            letter: nil
        ),
        Letter(
            name: "Aditya Chauhan",
            profession: "Intern",
            goal: "Today was overwhelming but I learned so much about...",
            targetDate: Date().addingTimeInterval(-86400),
            createdAt: Date().addingTimeInterval(-86400 * 10),
            letter: nil
        )
    ]
    
    @State private var showAddSheet: Bool = false
    @Binding var path: NavigationPath

    var body: some View {
        

            ZStack {
                Image("background_image")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.5).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(letters) { letter in
                            LetterCardView(letter: letter)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Smriti")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showAddSheet = true }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 32, height: 32)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationStack{
                    NewLetterView(path: $path)
                }
            }
    }
}
