//
//  FeedbackView.swift
//  MealSwap
//
//  Created by Bryan Pineda on 4/20/24.
//

/**
 
 Bryan Notes:
 
   Important: There is Logic to be added
 
        - User must be able to submit feedback
        - Feedback should be stored in a database
 **/



import SwiftUI
struct FeedbackView: View {
    @State private var feedbackText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Your Feedback")) {
                    
                    TextEditor(text: $feedbackText)
                        .frame(height: 200)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                
                    Button(action: {
                        submitFeedback()
                    }) {
                        Text("Submit Feedback")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding()
                    .buttonStyle(PlainButtonStyle())
                
            }
        }
        .navigationTitle("Feedback")

    }
    
    func submitFeedback() {
        
        print("Feedback submitted: \(feedbackText)")
        
    }
}

#Preview {
    FeedbackView()
}
