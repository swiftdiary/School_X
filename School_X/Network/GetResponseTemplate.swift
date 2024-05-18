//
//  GetResponseTemplate.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation

struct GetResponseTemplate<T:Decodable>: Decodable {
    let count: Int
    let next: Int?
    let previous: Int?
    let results: [T]
    
    enum CodingKeys: CodingKey {
        case count
        case next
        case previous
        case results
    }
    
}
