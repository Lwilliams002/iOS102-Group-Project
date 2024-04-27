//
//  Message.swift
//  MealSwap
//
//  Created by Jon Toussaint on 4/26/24.
//

import Foundation

struct Message: Hashable, Identifiable, Codable {
    let id: String
    let text: String
    let timestamp: Date
    let username: String
}

extension Message {
    static let mockedMessages: [Message] = [
        "Hey this looks delicious!",
        "Hi, yours does too. Want to swap?"
    ].enumerated().map { index, text in
        Message(id: UUID().uuidString, text: text, timestamp: Date(), username: index % 2 == 0 ? "jt@gmail.com" : "test@gmail.com")
    }
}
