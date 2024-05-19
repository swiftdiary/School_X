//
//  Content.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

struct Content: Identifiable, Codable {
    let id: Int
    let topic: Int
    let title: String?
    let text: String
    let photo: String?
    let photoWebp: String?
    let threeDUrl: String?
    let threeDFile: String?
    let updatedAt: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case topic
        case title
        case text
        case photo
        case photoWebp = "photo_webp"
        case threeDUrl = "three_d_url"
        case threeDFile = "three_d_file"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

