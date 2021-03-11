//
//  FiltersTableViewCell.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure cell
        selectionStyle = .none
    }
    
    // MARK: - Public API
    
    func configure(with presentable: FiltersPresentable) {
        // Configure Label
        label.text = presentable.text
        
        // Configure Accessory Type
        accessoryType = presentable.selected ? .checkmark : .none
    }

}
