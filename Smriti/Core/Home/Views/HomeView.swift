//
//  HomeView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 19/01/26.
//

import SwiftUI
import _SwiftData_SwiftUI

struct HomeView: View {
    @Query(sort: \Letter.createdAt, order: .reverse)
    private var letters: [Letter]
    @State private var showAddSheet: Bool = false
    @Binding var path: NavigationPath
    @State private var selectedLetter: Letter?
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
                            LetterCardView(letter: letter).onTapGesture {
                                
                                selectedLetter = letter
                            }

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
                          Button {
                              showAddSheet = true
                          } label: {
                              Image(systemName: "plus")
                                  .font(.system(size: 16, weight: .bold))
                                  .foregroundStyle(.white)
                                  .frame(width: 32, height: 32)
                                  .background(.ultraThinMaterial)
                                  .clipShape(Circle())
                          }
                      }
                  }
                  
                  .sheet(isPresented: $showAddSheet) {
                      NavigationStack {
                          NewLetterView(path: $path)
                      }
                      .preferredColorScheme(.dark)
                      .presentationDetents([.medium, .large])
                      .presentationCornerRadius(28)
                      .presentationBackground(.clear)
                      .background {
                          GlassSheetBackground()
                              .ignoresSafeArea()
                      }
                  }
                  .sheet(item: $selectedLetter) { letter in
                      LetterDetailView(letter: letter)
                          .preferredColorScheme(.dark)
                          .presentationDetents([.medium, .large])
                          .presentationCornerRadius(28)
                          .presentationDragIndicator(.visible)
                          .presentationBackground(.clear)
                          .background {
                              GlassSheetBackground()
                                  .ignoresSafeArea()
                          }
                  }

    }
}

