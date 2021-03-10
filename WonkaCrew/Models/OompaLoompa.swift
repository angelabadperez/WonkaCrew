//
//  OompaLoompa.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

struct OompaLoompa: Decodable {
    
    // MARK: - Decodable Protocol
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case age
        case height
        case gender
        case profession
        case country
        case favorites = "favorite"
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        email = try values.decode(String.self, forKey: .email)
        age = try values.decode(Int.self, forKey: .age)
        height = try values.decode(Int.self, forKey: .height)
        gender = Gender(string: try values.decode(String.self, forKey: .gender))
        profession = Profession(string: try values.decode(String.self, forKey: .profession))
        country = try values.decode(String.self, forKey: .country)
        favorites = try values.decode(Favorites.self, forKey: .favorites)
        image = try values.decode(String.self, forKey: .image)
    }
    
    // MARK: - Properties
    
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let age: Int
    let height: Int
    let gender: Gender
    let profession: Profession
    let country: String
    let favorites: Favorites
    let image: String
}
