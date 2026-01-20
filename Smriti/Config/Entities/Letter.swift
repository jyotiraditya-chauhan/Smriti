//
//  Letter.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import Foundation

struct Letter: Identifiable,Hashable {
    let id = UUID()
    let name: String
    let profession: String
    let goal: String?
    let targetDate: Date
    let createdAt: Date
    let letter: String?
}
