//
//  Player.swift
//  ScoreKeeper
//
//  Created by Emir Keles on 22.07.2026.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
}
