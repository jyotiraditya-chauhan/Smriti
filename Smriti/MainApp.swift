//
//  ContentView.swift
//  Smriti
//
//  Created by Aditya Chauhan on 19/01/26.
//


import SwiftUI
import AVKit

struct MainApp: View {
    @State private var path = NavigationPath()
    @State private var player: AVPlayer?
    @State private var LogoPlayer: AVPlayer?
    @State private var transitionOpacity: Double = 0.0

    var body: some View {
        NavigationStack{
            ZStack {
                
                if let player = player {
                    VideoPlayer(player: player)
                        .scaledToFill()
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }
                
                RadialGradient(
                    colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(0.3),
                        Color.black.opacity(0.8)
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: 600
                )
                .ignoresSafeArea()
                .opacity(transitionOpacity)
                .allowsHitTesting(false)
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.black.opacity(0.2),
                                Color.black.opacity(0.6)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                
                
                VStack( spacing: 12) {
                    HStack{
                        VStack(alignment: .leading) {
//                            Image("logo").resizable().frame(width: 120,height: 120).cornerRadius(3000)
                            if let logoPlayer = LogoPlayer {
                                VideoPlayer(player: logoPlayer)
                                    .frame(width: 120, height: 120)
                                    .scaleEffect(2)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white.opacity(0.15), lineWidth: 1)
                                    )
                                    .shadow(color: .black.opacity(0.6), radius: 10)
                                    .allowsHitTesting(false)
                            }

                                Text("Smriti")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white).padding(.leading, 10)

                            
                        }.padding(.trailing, 200)
                    
                    }
                    Spacer()
                    Text("A quiet space for reflection, remembrance, and inner stillness")
                        .font(.system(size: 14, weight: .semibold,design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 20).frame(width: 300)

                    NavigationLink(destination:     HomeView(path:  $path)){
                        AnimatedGradientButton().padding(.bottom, 60)
                    }
                }
            }
            
            .onAppear {
                setupLoopingVideoWithFade()
                setupLoopingVideoWithFadeForLogo()
            }
            .onDisappear {
                removeObserver()
            }
        }
    }
    private func setupLoopingVideoWithFade() {
        guard let url = videoURLFromAssets(named: "video", withExtension: "mp4") else { return }

        let avPlayer = AVPlayer(url: url)
        avPlayer.isMuted = true
        avPlayer.actionAtItemEnd = .none
        player = avPlayer

        avPlayer.play()

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: avPlayer.currentItem,
            queue: .main
        ) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                transitionOpacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                avPlayer.seek(to: .zero)
                avPlayer.play()
                withAnimation(.easeInOut(duration: 0.6)) {
                    transitionOpacity = 0.0
                }
            }
        }
    }
    
    private func setupLoopingVideoWithFadeForLogo() {
        guard let url = videoURLFromAssets(named: "logo_video", withExtension: "mp4") else { return }

        let avPlayer = AVPlayer(url: url)
        avPlayer.isMuted = true
        avPlayer.actionAtItemEnd = .none

        LogoPlayer = avPlayer
        avPlayer.play()

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: avPlayer.currentItem,
            queue: .main
        ) { _ in
            avPlayer.seek(to: .zero)
            avPlayer.play()
        }
    }

    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}

#Preview {
    NavigationStack {
        MainApp()
    }
}


struct AnimatedGradientButton: View {
    @State private var rotation: Double = 0
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    AngularGradient(
                        colors: [
                            Color(red: 0.4, green: 0.2, blue: 0.6),
                            Color(red: 0.6, green: 0.3, blue: 0.8),
                            Color(red: 0.3, green: 0.15, blue: 0.5),
                            Color(red: 0.5, green: 0.25, blue: 0.7),
                            Color(red: 0.4, green: 0.2, blue: 0.6)
                        ],
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    lineWidth: 3
                )
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(rotation))
                .shadow(color: Color.purple.opacity(0.5), radius: 8, x: 0, y: 0)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0.15, green: 0.1, blue: 0.2),
                            Color(red: 0.1, green: 0.05, blue: 0.15),
                            Color.black.opacity(0.9)
                        ],
                        center: .center,
                        startRadius: 5,
                        endRadius: 40
                    )
                )
                .frame(width: 74, height: 74)
            
            Image(systemName: "arrow.right")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.white)
                .offset(x: isPressed ? 4 : 0)
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}


func videoURLFromAssets(named name: String, withExtension ext: String) -> URL? {
    guard let asset = NSDataAsset(name: name) else {
        print("Asset not found")
        return nil
    }

    let tempURL = FileManager.default.temporaryDirectory
        .appendingPathComponent("\(name).\(ext)")

    do {
        try asset.data.write(to: tempURL)
        return tempURL
    } catch {
        print("Failed to write video data:", error)
        return nil
    }
}
