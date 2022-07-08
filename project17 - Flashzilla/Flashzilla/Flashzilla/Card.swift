//
//  Card.swift
//  Flashzilla
//
//  Created by Derek Howes on 5/20/22.
//

import Foundation

struct Card: Codable, Hashable, Identifiable {
    let id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who can master all four elements", answer: "The Avatar")
    
}
