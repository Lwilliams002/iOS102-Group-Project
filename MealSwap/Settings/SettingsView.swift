
//
//  SettingsView.swift
//  MealSwap
//
//  Created by Bernard Laughlin on 4/14/24.
//

/**
 
 Bryan Notes:
 
   Important: There is Logic to be added
 
        - User Must be able to save and change profile picture
        - Profile Picture Must be added to a data base
        - User Profile name must be shown
        - Use Firebase FireStore database to fetch username and display
 **/


import SwiftUI
import PhotosUI

struct SettingsView: View {
    
    @Environment(AuthManager.self) var authManager // Added to fetch user email for now
    
    @StateObject var viewModel = ProfileViewModel() // Used for profile picture logic
    
    let user : UserInfo // This is not used at the moment
    

    var body: some View {
        NavigationView {
            VStack{
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                
                //Profile Picture
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage{
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                    } else {
                        
                        Image(user.profileImageUrl ?? "")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                        
                    }
                    
                    
                    
                }// End of profile picture, logic will be updated
                
                
                
                Text(viewModel.username ?? "Username")
                    .padding(5)
                Text("City, State")
                    .padding(10)
                
                
                Text("My Meal Ratings:")
                    .fontWeight(.bold)
                RatingView(rating: 4)
                
                Spacer()
                
                
                //Navigation links
                
                NavigationLink {
                    // destination view to navigation to
                    AccountView()
                } label: {
                    HStack{
                        Text("My Account")
                        Spacer()
                        Image(systemName: "person")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 40)
                    .background(Color.black)
                    .cornerRadius(8)
                }
                
                NavigationLink {
                    // destination view to navigation to
                    DietaryView()
                } label: {
                    HStack{
                        Text("Dietary Preferences")
                        Spacer()
                        Image(systemName: "fork.knife.circle")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 40)
                    .background(Color.black)
                    .cornerRadius(8)
                }
                
                NavigationLink {
                    // destination view to navigation to
                    AboutView()
                } label: {
                    HStack{
                        Text("About Us")
                        Spacer()
                        Image(systemName: "book")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 40)
                    .background(Color.black)
                    .cornerRadius(8)
                }
                
                
                NavigationLink {
                    // destination view to navigation to
                    FeedbackView()
                } label: {
                    HStack{
                        Text("Feedback & Support")
                        Spacer()
                        Image(systemName: "hands.and.sparkles")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 40)
                    .background(Color.black)
                    .cornerRadius(8)
                }
                Spacer()
                
                //Button to LOG OUT
                Button(action: {
                    print("User sign out")
                    authManager.signOut()
                }) {
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding()
                
                
                
            }
            
            
        }
    }
}

#Preview {
    SettingsView(user: UserInfo.MOCK_USER)
        .environment(AuthManager())
}
