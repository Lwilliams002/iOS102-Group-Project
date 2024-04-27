//
//  MatchedDetailView.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/26/24.
//

import SwiftUI

struct MatchedDetailView: View {
    @Environment(AuthManager.self) var authManager: AuthManager
    
    @Binding var meal: Meal?
    @State private var isAvailable = true // eventually get this to meal model
    
    @State private var showingChat = false
    @State private var showingSwappedConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MealCard(meal: $meal)
                    .overlay(bottomTrailingLabel("4.4 miles away"))
                    .padding(.horizontal)
                
                HStack {
                    Button {
                        showingChat = true
                    } label: {
                        styledLabel("Chat with User",
                                    systemImage: "bubble.right",
                                    color: .init(uiColor: .systemGray6))
                    }
                    Spacer()
                    Button {
                        showingSwappedConfirmation = true
                    } label: {
                        styledLabel(isAvailable ? "Available" : "Unavailable",
                                    systemImage: isAvailable ? "checkmark" : "xmark",
                                    color: isAvailable ? .green : .red)
                    }
                    
                }
                .foregroundStyle(.primary)
                .opacity(isAvailable ? 1 : 0.6)
                .padding(.top)
            }
            .padding()
        }
        .sheet(isPresented: $showingChat) {
            if let meal {
                ChatView(meal: meal, isMocked: true)
                    .environment(authManager)
            }
        }
        .alert(isPresented: $showingSwappedConfirmation) {
            Alert(title: Text("Confirm Swap"),
                  message: Text("Finalize your agreement to swap?"),
                  primaryButton: .destructive(Text("Confirm"), action: markAsSwapped),
                  secondaryButton: .cancel())
        }
    }
    
    private func styledLabel(_ text: String, systemImage: String, color: Color) -> some View {
        Label(text, systemImage: systemImage)
            .fontWeight(.medium)
            .padding()
            .background(color)
            .clipShape(.capsule)
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
    
    private func markAsSwapped() {
        // TODO: - eventually should change meal model
        
        isAvailable.toggle() // for now, just toggling UI property
    }
}

#Preview {
    MatchedDetailView(meal: .constant(Meal.example))
        .environment(AuthManager(isMocked: true))
}
