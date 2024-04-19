//
//  MealFeed.swift
//  MealSwap
//
//  Created by Lesly Williams on 4/14/24.
//

import SwiftUI
import Combine


struct MealFeed: View {
    @State private var mealImage: UIImage? = nil
    @State private var mealTitle: String = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Button("Feed"){
                    
                }
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .frame(width: 120, height: 50)
                
                Spacer()
                Button("Follower"){
                    
                }
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .frame(width: 120, height: 50)
            }
            .frame(width: 200)
            

            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.gray)
                    .overlay(
                        VStack{
                            if let mealImage = mealImage{
                                Image(uiImage: mealImage)
                                    .resizable()
                                    .scaledToFit()
                            }
                            Text(mealTitle)
                                .font(.title)
                                .foregroundStyle(.white)
                        })
            }
            .frame(width: 350, height: 600)
            .onAppear{
                isLoading = true
                Task{
                    await fetchFeed()
                    isLoading = false
                }
            }
        }
        
    }
    
    private func fetchFeed() async {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian")!
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let feedsResponse = try JSONDecoder().decode(FeedModel.self, from: data)
            
            let feeds = feedsResponse.meals
            
            for feed in feeds{
                print(feed.idMeal)
                mealTitle = feed.strMeal
                if let image = await loadImage(from: feed.strMealThumb) {
                    mealImage = image
                }
                break
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
//    private func fetchMeal() async {
//            let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772")!
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                
//                let mealData = try JSONDecoder().decode(MealModel.self, from: data)
//                
//                let meals = mealData.meals
//                
//                for meal in meals{
//                    print(meal.strMeal)
//                }
//            } catch {
//                print(error.localizedDescription) // Error handling
//            }
//        }
    
    private func loadImage(from url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
}

#Preview {
    MealFeed()
}
