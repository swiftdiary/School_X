//
//  Profile.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

struct Profile: Codable {
    let id: Int
    let firstName: String
    let coin: Int
    let dateJoined: String
    let quizActivity: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case coin
        case dateJoined = "date_joined"
        case quizActivity = "quiz_activity"
    }
}
