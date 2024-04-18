//
//  FeedModel.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/14/24.
//

import SwiftUI

struct FeedModel: Codable {
    let meals: [Feed]
}

struct Feed: Codable {
    let strMeal: String // Title
    let strMealThumb: String // image source
    let idMeal: String
}
