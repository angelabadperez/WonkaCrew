//
//  OompaLoompaViewModel.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

struct OompaLoompaViewModel: OompaLoompaPresentable {
    
    // MARK: - Properties
    
    let oompaLoompa: OompaLoompa
    
    // MARK: - Public API
    
    var fullName: String {
        return "\(oompaLoompa.firstName) \(oompaLoompa.lastName)"
    }
    
    var profession: String {
        return "\(oompaLoompa.profession)".capitalized
    }
    
    var gender: String {
        return "\(oompaLoompa.gender)".capitalized
    }
    
    var email: String {
        return oompaLoompa.email
    }
    
    var country: String {
        return oompaLoompa.country
    }
    
    var age: Int {
        return oompaLoompa.age
    }
    
    var height: Int {
        return oompaLoompa.height
    }

    var color: String {
        return oompaLoompa.favorites.color.capitalized
    }
    
    var food: String {
        return oompaLoompa.favorites.food.capitalized
    }
    
    var song: String {
        return oompaLoompa.favorites.song
    }
    
    var image: String {
        return oompaLoompa.image
    }
    
}
