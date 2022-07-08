//
//  Activity.swift
//  Drawing
//
//  Created by Derek Howes on 4/28/22.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var count: Int = 0
}
