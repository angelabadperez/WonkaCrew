//
//  TableView.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import UIKit

extension UITableView {
    func setEmptyView(_ view: UIView) {
        self.backgroundView = view
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
