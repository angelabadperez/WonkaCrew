//
//  CrewList.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 8/3/21.
//

import Foundation

struct CrewList: Decodable {
    
    // MARK: - Decodable Protocol
    
    enum CodingKeys: String, CodingKey {
        case page = "current"
        case count = "total"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        count = try container.decode(Int.self, forKey: .count)
        results = try container.decode([OompaLoompa].self, forKey: .results)
    }
    
    // MARK: - Properties
    
    let page: Int
    let count: Int
    let results: [OompaLoompa]
}
