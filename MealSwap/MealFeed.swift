//
//  MealFeed.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/14/24.
//

import SwiftUI

struct MealFeed: View {
    
    private enum SwipeDirection { case right, left }
    
    private func swiped(_ direction: SwipeDirection) {
        switch direction {
        case .right:
            print("👉 Swiped right")
            meals.removeLast()
            print(meals.map { $0?.title })
            print("now \(meals.count) elements")
            // Show some feedback
            
            // if remaining meals.count is low, fetch more meals
            if meals.count < 2 {
                Task {
                    await fetchMeals()
                }
            }
        case .left:
            print("👈 Swiped left")
            meals.removeLast()
            print(meals.map { $0?.title })
            print("now \(meals.count) elements")
            // Show some feedback
            
            // if remaining meals.count is low, fetch more meals
            if meals.count < 2 {
                Task {
                    await fetchMeals()
                }
            }
        }
    }
    
    @State private var meals: [Meal?] = []
    
    @State private var offset: CGSize = .zero
    private let swipeThreshold: Double = 200
    
    var body: some View {
        VStack{
            buttonRow
                .frame(width: 200)
            
            ZStack {
                ForEach(0..<meals.count, id: \.self) { index in
                    MealCard(meal: $meals[index])
                        .frame(width: 350, height: 600)
                        .if(index == meals.count - 1) { view in
                            view
                                .rotationEffect(.degrees(offset.width / 20.0))
                                .opacity(3 - abs(offset.width) / swipeThreshold * 3)
                                .offset(CGSize(width: offset.width, height: 0))
                                .gesture(DragGesture()
                                            .onChanged { gesture in
                                                let translation = gesture.translation
                                                offset = translation
                                            }
                                            .onEnded{ gesture in
                                                if gesture.translation.width > swipeThreshold {
                                                    swiped(.right)
                                                    offset = .zero
                                                } else if gesture.translation.width < -swipeThreshold {
                                                    swiped(.left)
                                                    offset = .zero
                                                } else {
                                                    print("🚫 Swipe canceled")
                                                    withAnimation(.bouncy) {
                                                        offset = .zero
                                                    }
                                                }
                                            }
                                        )
                        }
                        .rotationEffect(.degrees(Double(meals.count - 1 - index) * -1))
                }
            }
            .padding(.horizontal)
            
        }
        .task{
            if meals.count < 2 {
                await fetchMeals()
            }
        }
        .onChange(of: meals) { _, newValue in
            print("meals changed: \(newValue.map { $0?.title })")
        }
    }
    
    /// Fetches some meals and adds them to the meals array
    private func fetchMeals() async {
        for _ in 0..<5 {
            let newMeal = await Meal.fetchRandom()
            meals.append(newMeal)
        }
        print(meals.map { $0?.title })
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

/// https://www.avanderlee.com/swiftui/conditional-view-modifier/
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
