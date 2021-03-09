//
//  FiltersPresentable.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import UIKit

protocol FiltersPresentable {
    
    // MARK: - Properties
    
    var text: String { get }
    var selected: Bool { get }

    func select()
}
