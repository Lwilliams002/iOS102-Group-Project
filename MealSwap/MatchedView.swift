//
//  MatchedView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/24/24.
//

import SwiftUI

struct MatchedView: View {
    @Environment(AuthManager.self) var authManager: AuthManager
    
    @State private var mealStore: MealStore = MealStore(matchedMeals: [.example!, .example2!, .example3!])
    
    
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
                                .environment(authManager)
                        } label: {
                            MealCard(meal: self.mealStore.bindingForIndex(index), smallTextDisplay: true)
                        }
                        .foregroundStyle(Color.primary)
                    }
                    .padding(10)
                }
            }
            .navigationTitle("Matched Meals")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MatchedView()
        .environment(AuthManager(isMocked: true))
}
