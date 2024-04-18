//
//  ContentView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var feeds: [Feed] = []
    
    var body: some View {
        VStack {
            TabView {
                Text("Meals Feed")
                    .tabItem { Label("Find Meals", systemImage: "fork.knife") } // Segue to MealFeed View
                Text("Create Meal")
                    .tabItem { Label("Post New", systemImage: "plus.circle") }
                Text("Matched Meals")
                    .tabItem { Label("Swap Meals", systemImage: "arrow.left.arrow.right") }
                Text("Settings")
                    .tabItem { Label("Settings", systemImage: "person") }
            }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
