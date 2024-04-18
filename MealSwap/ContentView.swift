//
//  ContentView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/13/24.
//

import SwiftUI

struct ContentView: View {
        issue-#1
    @State private var feeds: [Feed] = []
  
    @Environment(AuthManager.self) var authManager
        main
    
    var body: some View {
        VStack {
            TabView {
                MealFeed()
                    .tabItem { Label("Find Meals", systemImage: "fork.knife") } // Segue to MealFeed View
                Text("Create Meal")
                    .tabItem { Label("Post New", systemImage: "plus.circle") }
                Text("Matched Meals")
                    .tabItem { Label("Swap Meals", systemImage: "arrow.left.arrow.right") }
                SettingsView()
                    .environment(authManager)
                    .tabItem { Label("Settings", systemImage: "person") }
            }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
        .environment(AuthManager())

}
