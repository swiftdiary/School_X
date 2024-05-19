//
//  Topic.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

struct Topic: Identifiable, Hashable, Codable {
    let id: Int
    let subject: Int
    let title: String
    let description: String
    let photo: String?
    let photoWebp: String?
    let updatedAt: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case subject
        case title
        case description
        case photo
        case photoWebp = "photo_webp"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
