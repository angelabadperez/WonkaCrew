//
//  FilterGenderViewModel.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import Foundation

struct FilterGenderViewModel: FiltersPresentable {
    
    // MARK: - Properties
    
    let gender: Gender
    
    // MARK: - Public API
    
    var text: String {
        return "\(gender)".capitalized
    }
    
    var selected: Bool {
        return UserDefaults.gender == gender
    }
    
    func select() {
        UserDefaults.gender = selected ? nil : gender
    }
}
