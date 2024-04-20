//
//  DietaryView.swift
//  MealSwap
//
//  Created by Bryan Pineda on 4/20/24.
//

/**
 
 Bryan Notes:
 
   Important: There is Logic to be added
 
        - User can select preferences
        - User's Preferences will then be applied to account
        - User should be matched with other users based on preferences
        - User Must be able to save and change preferences
 **/

import SwiftUI

struct DietaryView: View {
    @State private var vegetarianSelected = false
    @State private var veganSelected = false
    @State private var glutenFreeSelected = false

    var body: some View {
        VStack{
        
            
        Section(header: Text("Select Preferences")) {
                    Toggle(isOn: $vegetarianSelected) {
                        Text("Vegetarian")
                    }
                    Toggle(isOn: $veganSelected) {
                        Text("Vegan")
                    }
                    Toggle(isOn: $glutenFreeSelected) {
                        Text("Gluten-Free")
                    }
            }.padding(10)
        
            Spacer()
            
        Button(action: {
        
                    saveDietaryPreferences()
                }) {
                    Text("Save Preferences")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }

            
        }
        .navigationTitle("Dietary Preferences")

    }

    func saveDietaryPreferences() {
   
        print("Vegetarian: \(vegetarianSelected)")
        print("Vegan: \(veganSelected)")
        print("Gluten-Free: \(glutenFreeSelected)")

    }
}


#Preview {
    DietaryView()
}
