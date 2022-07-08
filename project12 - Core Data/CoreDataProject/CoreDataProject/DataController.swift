//
//  DataController.swift
//  CoreDataProject
//
//  Created by Derek Howes on 5/3/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
}
