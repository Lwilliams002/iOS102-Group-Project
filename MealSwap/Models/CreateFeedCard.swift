//
//  CreateFeedCard.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/15/24.
//

import SwiftUI

struct CreateFeedCard: View {
    @State private var mealTitle: String = ""
    @State private var category: String = ""
    @State private var area: String = ""
    @State private var instructions: String = ""
    @State private var ingredient1: String = ""
    @State private var mealImageURL: String = ""
   
    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Meal Title", text: $mealTitle)
                TextField("Category", text: $category)
                TextField("Area", text: $area)
                TextField("Ingredient 1", text: $ingredient1)
                TextField("Image URL", text: $mealImageURL)
            }

            Section(header: Text("Instructions")) {
                TextEditor(text: $instructions)
            }

            // Preview Section
            Section(header: Text("Preview")) {
                VStack(alignment: .leading) {
                    Text(mealTitle).font(.title)
                    Text("Category: \(category)")
                    Text("Area: \(area)")
                    Text("Ingredients: \(ingredient1)") // Add more if you implement multiple ingredients

                    if let url = URL(string: mealImageURL) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    Text("Instructions:")
                     .font(.headline)
                    Text(instructions)
                }
            }
        }
    }
    
   
}

struct CreateFeedCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateFeedCard()
    }
}

