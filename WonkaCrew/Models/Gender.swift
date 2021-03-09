//
//  Gender.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

enum Gender: Int, CaseIterable {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let male: String = "m"
        static let female: String = "f"
        static let error: String = "Could not load gender."
    }
    
    // MARK: - Enum cases
    
    case male
    case female
}

extension Gender {
    init(string: String) {
        switch string.lowercased() {
        case Constants.male: self = .male
        case Constants.female: self = .female
        default: fatalError(Constants.error)
        }
    }
}

extension Gender: Codable { }
