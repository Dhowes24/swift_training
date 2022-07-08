//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Derek Howes on 5/3/22.
//

import CoreData
import SwiftUI

enum predicateEnum: String {
    case A,S
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) {item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, predicate: predicateEnum = .A, @ViewBuilder content: @escaping (T) -> Content) {
\        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: predicate, filterKey, filterValue))
        self.content = content
    }
}

