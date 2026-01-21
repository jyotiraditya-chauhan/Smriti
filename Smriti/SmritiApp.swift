//
//  SmritiApp.swift
//  Smriti
//
//  Created by Aditya Chauhan on 19/01/26.
//

import SwiftUI
import SwiftData

@main
struct SmritiApp: App {
    var body: some Scene {
        WindowGroup {
                MainApp()
        }.modelContainer(for: Letter.self)
    }
}

