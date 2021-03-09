//
//  FilterProfessionViewModel.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import Foundation

struct FilterProfessionViewModel: FiltersPresentable {
    
    // MARK: - Properties
    
    let profession: Profession
    
    // MARK: - Public API
    
    var text: String {
        return "\(profession)".capitalized
    }
    
    var selected: Bool {
        return UserDefaults.professions.contains(profession)
    }
    
    func select() {
        if selected {
            if let index = UserDefaults.professions.firstIndex(of: profession) {
                UserDefaults.professions.remove(at: index)
            }
        } else {
            UserDefaults.professions.append(profession)
        }
    }
}
