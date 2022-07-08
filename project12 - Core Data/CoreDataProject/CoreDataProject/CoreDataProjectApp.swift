//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Derek Howes on 5/3/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
