//
//  Subject.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

struct Subject: Identifiable, Codable {
    let id: Int
    let title: String
    let photo: String
    let photoWebp: String
    let updatedAt: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case photo
        case photoWebp = "photo_webp"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
