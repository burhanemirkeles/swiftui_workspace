//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Emir Keles on 24.07.2026.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
