//
//  Auth+Response+Type.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

struct AuthResponseType: Codable {
    let userId: Int
    let name: String
    let refresh: String
    let access: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case refresh
        case access
    }
}
