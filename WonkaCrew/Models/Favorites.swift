//
//  Favorites.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 10/3/21.
//

import Foundation

struct Favorites: Decodable {
    
    // MARK: - Decodable Protocol
    
    enum CodingKeys: String, CodingKey {
        case color
        case song
        case food
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        color = try values.decode(String.self, forKey: .color)
        song = try values.decode(String.self, forKey: .song)
        food = try values.decode(String.self, forKey: .food)
    }
    
    // MARK: - Properties
    
    let color: String
    let song: String
    let food: String
}
