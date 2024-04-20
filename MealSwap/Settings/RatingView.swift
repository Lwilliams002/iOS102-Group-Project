//
//  RatingView.swift
//  MealSwap
//
//  Created by Bryan Pineda on 4/20/24.
//

import SwiftUI


/**
        Bryan Notes:
 
            - Logic will be update and code will be updated
 **/


struct RatingView: View {
    var rating: Int
    var maximumRating: Int = 5
    var offImage: Image = Image(systemName: "star")
    var onImage: Image = Image(systemName: "star.fill")
    var offColor: Color = Color.gray
    var onColor: Color = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { index in
                self.image(for: index)
                    .foregroundColor(index > self.rating ? self.offColor : self.onColor)
            }
        }
    }
    
    private func image(for index: Int) -> Image {
        return index > rating ? offImage : onImage
    }
}

#Preview {
    RatingView(rating: 4)
}
