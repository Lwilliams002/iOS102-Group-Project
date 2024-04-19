//
//  Meal.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import Foundation

// TODO: - handle Firebase persistence once that's set up

/// This is our usable Meal struct, which we can use for user-generated meals as well as mocked meals from an API
struct Meal: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String // for random API generated meals, will be instructions
    let ingredients: [String]
    let photoURL: String?
    let photoData: [Data]
    
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
    
    static var example: MealsAPIItem? {
        guard let fileURL = Bundle.main.url(forResource: "example-meal", withExtension: "json") else { return nil }
        if let data = try? Data(contentsOf: fileURL) {
            if let json = try? JSONDecoder().decode(MealsAPIResponse.self, from: data) {
                return json.meals.first
            }
        }
        return nil
    }
}
