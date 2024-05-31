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
                                                print(offset)
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
                HStack(alignment: .center) {
                    arrow(facing: .left)
                        .opacity(offset.width < 0 ? 1.0 : 0)
                        .padding(.top, 30)
                    arrow(facing: .right)
                        .opacity(offset.width > 0 ? 1.0 : 0)
                        .padding(.bottom, 30)
                }
                .animation(.easeInOut, value: offset.width)
                
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        .safeAreaInset(edge: .top) {
            VStack {
                Image("MealSwapLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                buttonRow
                    .frame(width: 200)
                    .padding(.top, -10)
            }
            .frame(width: 200)
            
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
    
    private func arrow(facing direction: SwipeDirection) -> some View {
        Image("arrow")
            .renderingMode(direction == .right ? .original : .template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(direction == .right ? .primary : Color.red)
            .rotationEffect(direction == .right ? .degrees(180) : .zero)
            .shadow(radius: 8)
    }
    
    private func feedTypeButton(_ text: String, isActive: Bool) -> some View {
        Button(action: {}) {
            Text(text)
                .foregroundStyle(isActive ? .accent : .secondary)
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .background(
                    Capsule()
                        .foregroundStyle(isActive ? .accent.opacity(0.1) : .clear)
                        .frame(height: 30)
                )
        }
    }
    
    private var buttonRow: some View {
        HStack{
            feedTypeButton("Feed", isActive: true)
            Spacer()
            feedTypeButton("Follower", isActive: false)
        }
        .padding(.horizontal, 3)
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.thickMaterial)
                .frame(height: 35)
        )
        
        
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
