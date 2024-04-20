//
//  UserModel.swift
//  MealSwap
//
//  Created by Bryan Pineda on 4/19/24.
//


/**
 
 Bryan Notes:
 
   Important: Just a mocked model for user
    
        - Will probably delete or keep in the meantime
    
 
 **/

import Foundation

struct UserInfo: Codable, Identifiable {
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    
}


extension UserInfo{
    static let MOCK_USER = UserInfo(fullname: "Jhon Doe", email: "JhonDoe@gmail.com", profileImageUrl: "apple")
}
