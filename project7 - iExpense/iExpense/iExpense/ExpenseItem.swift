//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Derek Howes on 4/25/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
