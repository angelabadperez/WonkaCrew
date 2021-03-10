//
//  OompaLoompaPresentable.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

protocol OompaLoompaPresentable {
    
    // MARK: - Properties
    
    var fullName: String { get }
    var profession: String { get }
    var gender: String { get }
    var email: String { get }
    var country: String { get }
    var age: Int { get }
    var height: Int { get }
    var color: String { get }
    var food: String { get }
    var song: String { get }
    var image: String { get }
}
