//
//  MealCard.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import SwiftUI

struct MealCard: View {
    @Binding var meal: Meal?
    
    var smallTextDisplay: Bool = false
    
    var body: some View {
        VStack {
            if let meal {
                VStack {
                    HStack {
                        titleLabel(text: meal.title)
                        if !smallTextDisplay {
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .background(
                    AsyncImage(url: URL(string: meal.photoURL ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                    } placeholder: { loadingImageView }
                )
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
        }
        .aspectRatio(7/12, contentMode: .fill)
//        .animation(.easeInOut, value: meal)
    }
    
    private func titleLabel(text: String) -> some View {
        Text(text)
            .font(smallTextDisplay ? .body : .largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.leading)
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
        .frame(width: 350, height: 600)
}
