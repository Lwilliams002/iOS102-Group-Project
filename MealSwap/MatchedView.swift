//
//  MatchedView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/24/24.
//

import SwiftUI

struct MatchedView: View {
    @State private var mealStore: MealStore = MealStore(matchedMeals: [.example!, .example!, .example!])
    
    let data = (1...100).map { "Item \($0)" }

        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(mealStore.matchedMeals.indices, id: \.self) { index in
                            NavigationLink {
                                MatchedDetailView(meal: self.mealStore.bindingForIndex(index))
                            } label: {
                                MealCard(meal: self.mealStore.bindingForIndex(index),
                                         smallTextDisplay: true)
                                    .aspectRatio(7/12, contentMode: .fill)
                            }

                            
                        }
                        .padding(10)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Matched Meals")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
}

#Preview {
    MatchedView()
}
