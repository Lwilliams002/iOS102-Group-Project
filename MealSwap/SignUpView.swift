//
//  SignUpView.swift
//  MealSwap
//
//  Created by Bernard Laughlin on 4/19/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(AuthManager.self) var authManager

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var userName: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var aboutMe: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isVegan: Bool = false
    @State private var isPescetarian: Bool = false
    @State private var isVegetarian: Bool = false
    @State private var isGlutenFree: Bool = false
    @State private var isDairyFree: Bool = false
    @State private var isKeto: Bool = false
    @State private var isRawFood: Bool = false
    @State private var isPaleo: Bool = false

    private var states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Info")) {
                    TextField("Username", text: $userName)
                        .textInputAutocapitalization(.never)
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.never)

                }
                
                Section(header: Text("Name")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                Section(header: Text("Location")) {
                    TextField("City", text: $city)
                    Picker("State", selection: $state) {
                        ForEach(states, id: \.self) {
                            Text($0)
                        }
                        
                    }
                }
                Section(header: Text("About me")) {
                    TextField("About me", text: $aboutMe)
                    HStack{
                        Text("Choose Profile Pic")
                        Spacer()
                        Button { print("get photo")
                        } label: {Image(systemName: "camera") }
                    }
                }
                Section(header: Text("Dietary Preferences")) {
                    Toggle("Vegan", isOn: $isVegan)
                    Toggle("Pescetarian", isOn: $isPescetarian)
                    Toggle("Vegetarian", isOn: $isVegetarian)
                    Toggle("Dairy-Free", isOn: $isDairyFree)
                    Toggle("Gluten-Free", isOn: $isGlutenFree)
                    Toggle("Paleo", isOn: $isPaleo)
                    Toggle("Raw Food",isOn: $isRawFood)
                    Toggle("Keto", isOn: $isKeto)
                }
                Section() {
                    Button("Sign Up") {
                        print("Sign up user: \(email), \(password)")
                        authManager.signUp(email: email, password: password, userName: userName, firstName: firstName, lastName: lastName, about: aboutMe, city: city, state: state, isVegan: isVegan, isVegetarian: isVegetarian, isPescetarian: isPescetarian, isDairyFree: isDairyFree, isGlutenFree: isGlutenFree, isRawFood: isRawFood, isKeto: isKeto)
                        
                    }
                }
                
            }
            .navigationTitle("Create Accout")
        }
    }
}

#Preview {
    SignUpView()
        .environment(AuthManager())
}
