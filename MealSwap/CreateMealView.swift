//
//  CreateMealView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import SwiftUI

struct CreateMealView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var ingredients = [String]()
    
    @State private var newIngredient = ""
    
    var isValid: Bool {
        // For now, valid as long as there's a title
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What meal are you offering?") {
                    TextField("Title", text: $title)
                    descriptionField
                }
                ingredientSection
            }
            .navigationTitle("Offer\(title.isEmpty ? " New Meal" : "ing \(title)")")
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    submitButton
                }
            }
        }
    }
    
    private func postMeal() {
        let meal = Meal(title: title, description: description, ingredients: ingredients)
        // TODO: - add meal to database
        print("Posting \(meal)")
        
        title = ""
        description = ""
        ingredients = []
    }
    
    private var ingredientSection: some View {
        Section {
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
            .onDelete(perform: deleteIngredient)
            
            HStack {
                TextField("Add Ingredient", text: $newIngredient)
                    .foregroundStyle(.secondary)
                    .onSubmit { addIngredient() }
                Button(action: addIngredient) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(Color.accentColor)
                }
            }
        } header: {
            Text("\(ingredients.count) Ingredient\(ingredients.count == 1 ? "" : "s")")
        } footer: {
            Text("Please add all ingredients as users may have allergies/sensitivities to certain foods.")
        }
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    private func addIngredient() {
        let ingredient = newIngredient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard ingredient.isEmpty == false else { return }
        ingredients.append(ingredient)
        newIngredient = ""
    }
    
    private var descriptionField: some View {
        ZStack {
            TextEditor(text: $description)
                .foregroundStyle(.secondary)
                
            if description.isEmpty {
                VStack {
                    HStack {
                        Text("Description")
                            .foregroundStyle(.tertiary)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 200)
    }
    
    private var submitButton: some View {
        Button(action: postMeal) {
            Label("Post Meal", systemImage: "arrow.up")
                .foregroundStyle(.white)
                .padding()
                .background(
                    Capsule()
                        .foregroundStyle(isValid ? Color.accentColor : .gray)
                )
                .padding()
        }
    }
}

#Preview {
        CreateMealView()
}
