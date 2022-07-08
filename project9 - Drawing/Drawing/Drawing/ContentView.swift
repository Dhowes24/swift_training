//
//  ContentView.swift
//  Drawing
//
//  Created by Derek Howes on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddActivity: Bool = false
    @StateObject var activities = Activities()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink(destination: ActivityDetailView(activity: activity, activities: activities) )
                        {
                        HStack {
                            Text("\(activity.title)")
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Activity Watcher")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
