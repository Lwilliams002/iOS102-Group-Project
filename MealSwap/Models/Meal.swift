//
//  Meal.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import Foundation
import SwiftUI

// TODO: - handle Firebase persistence once that's set up

class MealStore: ObservableObject {
    @Published var matchedMeals: [Meal] = []
    
    init(matchedMeals: [Meal]) {
        self.matchedMeals = matchedMeals
    }
    
    func bindingForIndex(_ index: Int) -> Binding<Meal?> {
        Binding<Meal?>(
            get: {
                guard self.matchedMeals.indices.contains(index) else { return nil }
                return self.matchedMeals[index]
            },
            set: { newValue in
                guard let newValue = newValue, self.matchedMeals.indices.contains(index) else { return }
                self.matchedMeals[index] = newValue
            }
        )
    }
}

/// This is our usable Meal struct, which we can use for user-generated meals as well as mocked meals from an API
struct Meal: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String // for random API generated meals, will be instructions
    let ingredients: [String]
    let photoURL: String?
    let photoData: [Data]
    
    // Mocked display string, would store a numerical type eventually
    var distanceString: String = Meal.getRandomDistanceString()
    
    init(id: String? = nil, title: String, description: String, ingredients: [String], photoURL: String? = nil, photoData: [Data] = []) {
        if let id {
            self.id = id
        } else {
            self.id = UUID().uuidString
        }
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.photoURL = photoURL
        self.photoData = photoData
    }
    
    init(fromAPIMeal apiMeal: MealsAPIItem) throws {
        self.id = apiMeal.idMeal
        self.title = apiMeal.strMeal
        self.description = apiMeal.strInstructions
        self.photoURL = apiMeal.strMealThumb
        self.photoData = []
        
        // Gather ingredients
        var ingredients: [String] = []
        let mirror = Mirror(reflecting: apiMeal)
        
        for child in mirror.children {
            if let property = child.label, property.contains(try Regex("strIngredient")) {
                if let ingredientStr = child.value as? String, !ingredientStr.isEmpty {
                    ingredients.append(ingredientStr)
                }
            }
        }
        self.ingredients = ingredients
    }
    
    static func fetchRandom() async -> Meal? {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php") else { return nil }
        
        // Fetch and decode random meal from API response
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MealsAPIResponse.self, from: data)
            if let meal = response.meals.first {
                return try Meal(fromAPIMeal: meal)
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
    
    static let example = try? Meal(fromAPIMeal: .example!)
    static let example2 = try? Meal(fromAPIMeal: .example2!)
    static let example3 = try? Meal(fromAPIMeal: .example3!)
    
    /// Mocked distance string
    static func getRandomDistanceString() -> String {
        let distance = Double.random(in: 0.5..<13.0)
        return String(format: "%.1f miles away", distance)
    }
}

// MARK: - API stuff (just for mock meal data)
struct MealsAPIResponse: Codable {
    let meals: [MealsAPIItem]
}

struct MealsAPIItem: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strIngredient6: String
    let strIngredient7: String
    let strIngredient8: String
    let strIngredient9: String
    let strIngredient10: String
    let strIngredient11: String
    let strIngredient12: String
    let strIngredient13: String
    let strIngredient14: String
    let strIngredient15: String
    let strIngredient16: String
    let strIngredient17: String
    let strIngredient18: String
    let strIngredient19: String
    let strIngredient20: String
    
    static var examples: [MealsAPIItem] {
        guard let fileURL = Bundle.main.url(forResource: "example-meal", withExtension: "json") else { return [] }
        if let data = try? Data(contentsOf: fileURL) {
            if let json = try? JSONDecoder().decode(MealsAPIResponse.self, from: data) {
                return json.meals
            }
        }
        return []
    }
    
    static var example: MealsAPIItem? { examples.first }
    static var example2: MealsAPIItem? { examples[1] }
    static var example3: MealsAPIItem? { examples[2] }
}
