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
        return oompaLoompa.profession
    }
    
    var image: String {
        return oompaLoompa.image
    }
    
}
