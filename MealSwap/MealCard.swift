//
//  MealCard.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/18/24.
//

import SwiftUI

struct MealCard: View {
    @Binding var meal: Meal?
    @State private var offset: CGSize = .zero
    private let swipeThreshold: Double = 200
    
    var body: some View {
        VStack {
            if let meal {
                VStack {
                    HStack {
                        titleLabel(text: meal.title)
                        Spacer()
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
        .frame(width: 350, height: 600)
        .rotationEffect(.degrees(offset.width / 20.0))
        .opacity(3 - abs(offset.width) / swipeThreshold * 3)
        .offset(CGSize(width: offset.width, height: 0))
        .gesture(DragGesture()
                    .onChanged { gesture in
                        let translation = gesture.translation
                        offset = translation
                    }.onEnded{ gesture in
                        if gesture.translation.width > swipeThreshold {
                            print("👉 Swiped right")
                            
                            // <-- Call swiped right closure
                            
                        } else if gesture.translation.width < -swipeThreshold {
                            print("👈 Swiped left")
                            
                            // <-- Call swiped left closure
                            
                        } else {
                            print("🚫 Swipe canceled")
                            withAnimation(.bouncy) {
                                offset = .zero
                            }
                        }
                    }
                )
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
