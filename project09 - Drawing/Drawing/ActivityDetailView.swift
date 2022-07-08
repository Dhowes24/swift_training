//
//  ActivityDetailView.swift
//  Drawing
//
//  Created by Derek Howes on 4/28/22.
//

import SwiftUI

struct ActivityDetailView: View {
    @State var activity: Activity
    
    @ObservedObject var activities: Activities
    
    @State var count = 0

    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("\(activity.description)")
                Spacer()
                Stepper("Completed activity \(count) times", value: $count, in: 0...10)
                Spacer()
            }
            .navigationTitle("\(activity.title)")
            .onAppear(){
                count = activity.count
            }
            .toolbar {
                Button {
                    let oldActivityIndex = activities.activities.firstIndex(of: activity)
                    
                    activities.activities[oldActivityIndex ?? 0] = Activity(title: activity.title, description: activity.description, count: count)
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            
            
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(title: "Test", description: "Test"), activities: Activities())
    }
}
