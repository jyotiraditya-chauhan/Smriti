//
//  LetterCardView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//


import SwiftUI
import SwiftData

struct LetterCardView: View {

    let letter: Letter
    @Environment(\.modelContext) private var context
    @State private var isShining = false

    var body: some View {
        HStack(spacing: 15) {
            Image(letter.locked ? "envelope_closed" : "envelope")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .animation(.spring, value: letter.locked)

            VStack(alignment: .leading, spacing: 4) {
                Text(letter.profession)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(letter.goal ?? "No goal set")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(letter.createdAt, format: .dateTime.day().month())
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.8))

                Text(letter.createdAt, format: .dateTime.hour().minute())
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.5))
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.08))
        .overlay {
            if letter.locked {
                GeometryReader { geo in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, .white.opacity(0.3), .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .rotationEffect(.degrees(30))
                        .offset(x: isShining ? geo.size.width + 100 : -100)
                        .frame(width: 60, height: geo.size.height * 2)
                        .position(x: isShining ? geo.size.width + 100 : -100, y: geo.size.height / 2)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    letter.locked
                    ? AnyShapeStyle(
                        LinearGradient(
                            colors: [Color.yellow, Color.orange, Color.yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    : AnyShapeStyle(Color.white.opacity(0.1)),
                    lineWidth: letter.locked ? 0.8 : 0.3
                )
        )
        .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
        .contentShape(Rectangle())
        .contextMenu {
            Button(role: .destructive) {
                deleteLetter()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .onAppear {
            if letter.locked {
                withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                    isShining = true
                }
            }
        }
    }

    private func deleteLetter() {
        withAnimation {
            context.delete(letter)
        }
    }
}
