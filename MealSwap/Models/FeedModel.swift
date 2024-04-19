//
//  FeedModel.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/14/24.
//

import SwiftUI

struct FeedModel: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable, Equatable {
    let strMeal: String // Title
    let strMealThumb: String // image source
    let idMeal: String
    
    var id: String { idMeal }
    
    static let example = Meal(strMeal: "Wontons", strMealThumb: "https://www.themealdb.com/images/media/meals/1525876468.jpg", idMeal: "52948")
    
    static func fetchRandom() async -> Meal? {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let feedsResponse = try JSONDecoder().decode(FeedModel.self, from: data)
            return feedsResponse.meals.first
        }
        catch{
            print(error.localizedDescription)
        }
        return nil
    }
}
