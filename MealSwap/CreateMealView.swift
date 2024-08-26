//
//  CreateMealView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import PhotosUI
import SwiftUI

struct CreateMealView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var ingredients = [String]()
    @State private var instructions = [String]()
    
    @State private var newIngredient = ""
    @State private var newInstruction = ""
    
    @State private var photoItem: PhotosPickerItem?
    @State private var photo: UIImage?
    
    @State private var showingPostedAlert = false
    
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
                instructionSection
                ingredientSection
                
                Section("Photo") {
                    HStack {
                        PhotosPicker("Add from Library...", selection: $photoItem, matching: .images)
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "camera")
                    }
                    if let photo {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .onChange(of: photoItem) { _, newValue in
                    Task {
                        if let loaded = try? await newValue?.loadTransferable(type: Data.self) {
                            let uiImage = UIImage(data: loaded)
                            photo = uiImage
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
                
            }
            .navigationTitle("Offer\(title.isEmpty ? " New Meal" : "ing \(title)")")
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    submitButton
                }
            }
            .alert("Meal posted successfully!", isPresented: $showingPostedAlert) {
                Button(action: {}) {
                    Text("OK") }
            }
        }
    }
    
    private func postMeal() {
        // TODO: - add instructions to database
        let meal = Meal(title: title, description: description, instructions: instructions, ingredients: ingredients)
        // TODO: - persist uploaded photo data in meal object as Data
        // TODO: - add meal to database
        print("Posting \(meal)")
        
        showingPostedAlert = true
        
        title = ""
        description = ""
        instructions = []
        ingredients = []
        photo = nil
    }
    private var instructionSection: some View {
        Section {
            ForEach(instructions, id: \.self) { instruction in
                Text(instruction)
            }
            .onDelete(perform: deleteInstruction)
            
            HStack {
                TextField("Add Instruction", text: $newInstruction)
                    .foregroundStyle(.secondary)
                    .onSubmit { addInstruction() }
                Button(action: addInstruction) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(Color.accentColor)
                }
            }
        } header: {
            Text("\(instructions.count) Instruction\(instructions.count == 1 ? "" : "s")")
        } footer: {
            Text("Please add all instructions needed to cook the meal.")
        }
    }
    
    private func deleteInstruction(at offsets: IndexSet) {
        instructions.remove(atOffsets: offsets)
    }
    
    private func addInstruction() {
        let instruction = newInstruction.trimmingCharacters(in: .whitespacesAndNewlines)
        guard instruction.isEmpty == false else { return }
        instructions.append(instruction)
        newInstruction = ""
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
