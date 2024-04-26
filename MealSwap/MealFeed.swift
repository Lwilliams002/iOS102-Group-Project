//
//  MealFeed.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/14/24.
//

import SwiftUI

struct MealFeed: View {
    @State private var meal: Meal?
    
    var body: some View {
        VStack{
            buttonRow
                .frame(width: 200)
            MealCard(meal: $meal)
                .frame(width: 350, height: 600)
        }
        .task{ await fetchMeal() }
        // at least just for debugging:
        .onTapGesture { Task { await fetchMeal() } }
    }
    
    private func fetchMeal() async {
        meal = await Meal.fetchRandom() // use random mock meal for now
    }
    
    private var buttonRow: some View {
        HStack{
            Button("Feed") { }
                .frame(width: 120, height: 50)
            Spacer()
            Button("Follower") { }
                .frame(width: 120, height: 50)
        }
        .foregroundColor(.primary)
        .font(.title3)
        .fontWeight(.bold)
    }
}

#Preview {
    MealFeed()
}
