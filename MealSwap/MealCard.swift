//
//  MealCard.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import SwiftUI

struct MealCard: View {
    @Binding var meal: Meal?
    
    var body: some View {
        VStack {
            if let meal {
                VStack {
                    HStack {
                        titleLabel(text: meal.strMeal)
                        Spacer()
                    }
                    Spacer()
                }
                .background(
                    AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                    } placeholder: { loadingImageView }
                )
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
        }
        .frame(width: 350, height: 600)
//        .animation(.easeInOut, value: meal)
    }
    
    private func titleLabel(text: String) -> some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .shadow(radius: 5)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding(10)
    }
    
    private var loadingImageView: some View {
        ZStack {
            Color.gray.opacity(0.5)
            ProgressView().font(.largeTitle)
        }
    }
}

#Preview {
    MealCard(meal: .constant(Meal.example))
}
