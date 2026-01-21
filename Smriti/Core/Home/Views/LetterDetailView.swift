//
//  LetterDetailView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//
import SwiftUI
import SwiftData

struct LetterDetailView: View {
    let letter: Letter
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var displayedContent: String = ""
    @State private var isAnimating: Bool = false
    @State private var wasLockedOnOpen: Bool = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(0.95)
                .ignoresSafeArea()
            LinearGradient(
                colors: [.black.opacity(0.4), .black.opacity(0.1)],
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(letter.name)
                                .font(.system(.title2, design: .serif))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Text(letter.profession.uppercased())
                                .font(.caption)
                                .fontWeight(.semibold)
                                .tracking(2)
                                .foregroundStyle(.white.opacity(0.6))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(letter.targetDate.formatted(date: .abbreviated, time: .omitted))
                                .font(.callout)
                                .fontDesign(.monospaced)
                                .foregroundStyle(.white.opacity(0.8))
                            
                            Image(systemName: "envelope.open.fill")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .padding(.top, 20)

                    Divider()
                        .overlay(.white.opacity(0.2))

                    VStack(alignment: .leading, spacing: 0) {
                        Text(displayedContent)
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .lineSpacing(8)
                            .foregroundStyle(.white.opacity(0.95))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        if isAnimating {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 2, height: 20)
                                .opacity(isAnimating ? 1 : 0)
                        }
                    }
                    .frame(minHeight: 200, alignment: .topLeading)

                    Spacer(minLength: 40)

                    if !isAnimating {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Sincerely,")
                                    .font(.system(.body, design: .serif))
                                    .italic()
                                    .foregroundStyle(.white.opacity(0.7))
                                
                                Text(letter.name)
                                    .font(.custom("Zapfino", size: 22))
                                    .foregroundStyle(.white)
                                    .opacity(0.8)
                                    .padding(.top, -10)
                            }
                            
                            Spacer()
                            
                            ShareLink(item: generateShareContent()) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white.opacity(0.8))
                                    .padding(12)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                        }
                        .transition(.opacity.animation(.easeIn(duration: 1.0)))
                    }
                }
                .padding(30)
            }
        }
        .onAppear {
            setupView()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private func setupView() {
        wasLockedOnOpen = letter.locked
        
        if letter.locked {
            letter.locked = false
            try? context.save()
        }
        
        startTypewriterEffect()
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTypewriterEffect() {
        stopTimer()
        
        guard let fullText = letter.letter else { return }
        
        if !wasLockedOnOpen {
            displayedContent = fullText
            return
        }
        
        isAnimating = true
        displayedContent = ""
        
        let words = fullText.split(separator: " ")
        var wordIndex = 0
    
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if wordIndex < words.count {
                let word = String(words[wordIndex])
                displayedContent += word + " "
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                wordIndex += 1
            } else {
                timer.invalidate()
                withAnimation {
                    isAnimating = false
                }
            }
        }
    }

    private func generateShareContent() -> String {
        guard let content = letter.letter else { return "" }
        return """
        \(content)
        
        Sincerely,
        \(letter.name)
        \(letter.profession)
        """
    }
}
