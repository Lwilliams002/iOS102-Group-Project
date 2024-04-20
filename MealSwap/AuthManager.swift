//
//  AuthManager.swift
//  MealSwap
//
//  Created by Bernard Laughlin on 4/14/24.
//

import Foundation
import FirebaseAuth // <-- Import Firebase Auth
import Firebase

@Observable // <-- Make class observable
class AuthManager {
    
    
    // A property to store the logged in user. User is an object provided by FirebaseAuth framework
    var user: User?

    // Determines if AuthManager should use mocked data
    let isMocked: Bool

    var userEmail: String? {

        // If mocked, return a mocked email string, otherwise return the users email if available
        isMocked ? "kingsley@dog.com" : user?.email
    }

    init(isMocked: Bool = false) {

       self.isMocked = isMocked
       user = Auth.auth().currentUser
    }

    // https://firebase.google.com/docs/auth/ios/start#sign_up_new_users
    func signUp(email: String, password: String, userName: String, firstName: String, lastName:String, about: String, city: String, state: String, isVegan: Bool, isVegetarian: Bool, isPescetarian: Bool, isDairyFree: Bool, isGlutenFree: Bool, isRawFood: Bool, isKeto:Bool, onFailure: @escaping (String, String) -> Void) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                user = authResult.user // <-- Set the user
            } catch {
                // Unable to create user
                onFailure("Unable to create user", error.localizedDescription)
            }
            
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let db = Firestore.firestore()
            do{
                try await db.collection("Users").document("\(userID)").setData(["email": email, "firstName": firstName, "lastName": lastName, "about": about, "city": city, "state": state, "isVegan": isVegan, "isVegetarian": isVegetarian, "isPescetarian": isPescetarian, "isDairyFree": isDairyFree, "isGlutenFree": isGlutenFree, "isRawFood": isRawFood, "isKeo": isKeto, "userID": userID])
            } catch {
                // Unable to add user to db
                onFailure("Unable to add user to database", error.localizedDescription)
            }
            
        }
    }

    // https://firebase.google.com/docs/auth/ios/start#sign_in_existing_users
    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                user = authResult.user // <-- Set the user
            } catch {
                print(error)
            }
            
            
        }
    }
    
        

    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil // <-- Set user to nil after sign out
        } catch {
            print(error)
        }
    }
}
