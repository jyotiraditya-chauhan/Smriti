//
//  Letter.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import SwiftData
import Foundation
import FoundationModels

@Model
class Letter {
    var id: UUID
    var name: String
    var profession: String
    var goal: String?
    var targetDate: Date
    var createdAt: Date
    var letter: String?
    var locked: Bool

    init(
        name: String,
        profession: String,
        goal: String?,
        targetDate: Date,
        createdAt: Date,
        letter: String?,
        locked: Bool
    ) {
        self.id = UUID()
        self.name = name
        self.profession = profession
        self.goal = goal
        self.targetDate = targetDate
        self.createdAt = createdAt
        self.letter = letter
        self.locked = locked
    }
}


