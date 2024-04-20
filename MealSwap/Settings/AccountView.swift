//
//  AccountView.swift
//  MealSwap
//
//  Created by Bryan Pineda on 4/19/24.
//

/**
 
 Bryan Notes:
 
   Important: There is Logic to be added
     
        - User can change email
        - User can change Password
        - User can save changes
 **/


import SwiftUI

struct AccountView: View {
    @Environment(AuthManager.self) var authManager

    
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack{
            Section(header: Text("Change Email")) {
                TextField("Enter new username", text: $newUsername)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section(header: Text("Change Password")) {
                SecureField("Enter new password", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm new password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section {
                Button("Save Changes") {
                    // Performing validation and saving logic here
                    if isValidInput() {
                        // Handle saving changes (e.g., update username and password)
                        print("New Username: \(newUsername)")
                        print("New Password: \(newPassword)")
                        // Optionally, clear fields after saving
                        clearFields()
                    } else {
                        // Show error or alert for invalid input
                        print("Invalid input. Please check your entries.")
                    }
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
            }
            
            Spacer()
            
            Button(action: {
                print("User sign out")
                authManager.signOut()
            }) {
                Text("Delete Account")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
            
            
        }
        .padding()
        .navigationTitle("Account Settings")
    }
    
    // Function to validate input (e.g., password matching)
    private func isValidInput() -> Bool {
        return !newUsername.isEmpty && !newPassword.isEmpty && newPassword == confirmPassword
    }
    
    // Function to clear input fields after saving changes
    private func clearFields() {
        newUsername = ""
        newPassword = ""
        confirmPassword = ""
    }
    
    
    
}



#Preview {
        AccountView()
    }

