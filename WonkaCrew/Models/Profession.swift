//
//  Profession.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import Foundation

enum Profession: Int, CaseIterable {
    
    // MARK: - Constants
    
    enum Constants {
        static let developer: String = "developer"
        static let metalworker: String = "metalworker"
        static let gemcutter: String = "gemcutter"
        static let medic: String = "medic"
        static let brewer: String = "brewer"
        static let error: String = "Could not load profession."
    }
    
    // MARK: - Enum cases
    
    case developer
    case metalworker
    case gemcutter
    case medic
    case brewer
}

extension Profession {
    init(string: String) {
        switch string.lowercased() {
        case Constants.developer: self = .developer
        case Constants.metalworker: self = .metalworker
        case Constants.gemcutter: self = .gemcutter
        case Constants.medic: self = .medic
        case Constants.brewer: self = .brewer
        default: fatalError(Constants.error)
        }
    }
}
