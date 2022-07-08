//
//  AddActivityView.swift
//  Drawing
//
//  Created by Derek Howes on 4/28/22.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var activities: Activities

    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)

                TextField("Description", text: $description)
                
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                Button("Save") {
                    let activity = Activity(title: title, description: description)
                    activities.activities.append(activity)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
