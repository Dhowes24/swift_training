//
//  Activities.swift
//  Drawing
//
//  Created by Derek Howes on 4/28/22.
//

import Foundation

class Activities: ObservableObject{
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activities = decodedItems
                return
            }
        }
        
        activities = []
    }
}
