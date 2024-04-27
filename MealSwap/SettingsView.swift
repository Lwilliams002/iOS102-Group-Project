
//
//  SettingsView.swift
//  MealSwap
//
//  Created by Bernard Laughlin on 4/14/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AuthManager.self) var authManager
    var body: some View {
        VStack{
            Text("Settings")
            Image(systemName: "person")
              .resizable()
              .frame(width: 100, height: 100)
              .padding(50)
              .foregroundColor(.white)
              .background(Color.gray)
              .clipShape(Circle())
              .padding()
            Text(authManager.userEmail ?? "Username")
                .padding(5)
            Text("New York, New York")
            Spacer()
            Button("Sign out") {
                print("User sign out")
                authManager.signOut()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    SettingsView()
        .environment(AuthManager())
}
