//
//  MealModel.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/18/24.
//

import SwiftUI

struct MealModel: Decodable {
  let meals: [Meal]

  enum CodingKeys: String, CodingKey {
    case meals
  }
}

struct Meal: Decodable {
  let idMeal: String
  let strMeal: String
  let strDrinkAlternate: String?
  let strCategory: String
  let strArea: String
  let strInstructions: String
  let strMealThumb: String
  let strTags: String
  let strYoutube: String
  let ingredients: [Ingredient]

  enum CodingKeys: String, CodingKey {
    case idMeal
    case strMeal
    case strDrinkAlternate
    case strCategory
    case strArea
    case strInstructions
    case strMealThumb
    case strTags
    case strYoutube
    case ingredients
  }
}

struct Ingredient: Decodable {
  let ingredient: String?
  let measure: String?

  enum CodingKeys: String, CodingKey {
    case ingredient = "strIngredient"
    case measure = "strMeasure"
  }
}


