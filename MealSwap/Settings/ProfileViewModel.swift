//
//  ProfileViewModel.swift
//  MealSwap
//
//  Created by Bryan Pineda on 4/19/24.
//


/**
 
 Bryan Notes:
    
        - This file is used for the profile picutre
        - User is able to use photo library to select a photo for profile picture
    
 Important note:
    
        - Will have to update this for being able to store and fetch profile picture
 
 **/


import Foundation
import SwiftUI
import PhotosUI

//Importing Firebase Firestore
import Firebase
import FirebaseFirestore




class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                do {
                    try await loadImage()
                } catch {
                    print("Error loading image: \(error)")
                }
            }
        }
    }
    
    @Published var profileImage: Image?
    @Published var username: String?
    
    private let db = Firestore.firestore()

    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        // Perform UI update on the main thread
        DispatchQueue.main.async {
            self.profileImage = Image(uiImage: uiImage)
        }
    }
    
    
    
    // Function to fetch username from Firestore with a completion handler
        func fetchUsername(forUserID userID: String, completion: @escaping (String?) -> Void) {
            let userRef = db.collection("users").document(userID)
            
            userRef.getDocument { document, error in
                if let error = error {
                    print("Error fetching user document: \(error)")
                    completion(nil)
                    return
                }
                
                guard let document = document, document.exists else {
                    completion(nil)
                    return
                }
                
                if let username = document.data()?["username"] as? String {
                    completion(username)
                } else {
                    completion(nil)
                }
            }
        }
        
        // Function to load username and update @Published property
        func loadUsername(forUserID userID: String) {
            fetchUsername(forUserID: userID) { username in
                DispatchQueue.main.async {
                    self.username = username
                }
            }
        }
    
    
    
    
    
}
