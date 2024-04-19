//
//  ContentView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) var authManager
    
    var body: some View {
        TabView {
            MealFeed()
                .tabItem { Label("Find Meals", systemImage: "fork.knife") }
            CreateMealView()
                .tabItem { Label("Post New", systemImage: "plus.circle") }
            Text("Matched Meals")
                .tabItem { Label("Swap Meals", systemImage: "arrow.left.arrow.right") }
            SettingsView()
                .environment(authManager)
                .tabItem { Label("Settings", systemImage: "person") }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())

}
