//
//  MealCardDetail.swift
//  MealSwap
//
//  Created by Lesly Williams on 8/25/24.
//

import SwiftUI

struct MealCardDetail: View{
    @Binding var meal: Meal?
    var smallTextDisplay: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            if let meal {
                NavigationLink(destination: MealCardDetail(meal: $meal)){
                    
                    VStack {
                        HStack {
                            titleLabel(text: meal.title)
                            if !smallTextDisplay {
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .background(Color(uiColor: .clear)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                VStack{
                    HStack{
                        IngredientsView(ingredients: meal.ingredients)
                        AsyncImage(url: URL(string: meal.photoURL ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: { loadingImageView }
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                    
                    InstructionsView(instructions: meal.instructions)
                }
                
            }
        }
        .aspectRatio(7/12, contentMode: .fill)
        
    }
    
    struct IngredientsView: View {
        var ingredients: [String]
        
        var body: some View {
            VStack(alignment: .leading) {
                ForEach(0..<ingredients.count, id: \.self) { index in
                    HStack {
                        Text("\(index + 1). \(ingredients[index])")
                    }
                    .padding(.vertical, 1)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
        }
    }
    struct InstructionsView: View {
    
        var instructions: [String]
        
        var body: some View {
            VStack(alignment: .leading) {
                ForEach(0..<instructions.count, id: \.self) { index in
                    HStack {
                        
                        Text("\(index + 1). \(instructions[index])")
                    }
                    .padding(.vertical, 2)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
        }
    }
    
    private func titleLabel(text: String) -> some View {
        Text(text)
            .font(smallTextDisplay ? .body : .largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.black)
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
    
    private func bottomTrailingLabel(_ text: String) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(text)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding(5)
            }
        }
    }
}

#Preview{
    MealCardDetail(meal: .constant(Meal.example))
        .frame(width: 350, height: 600)
}
