//
//  FiltersHeaderView.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import UIKit

class FiltersHeaderView: UIView {
    
    // MARK: - Private constants
    
    private enum Constants {
        enum Label {
            enum Constraints {
                static let fontName: String = "EuphemiaUCAS-Bold"
                static let fontSize: CGFloat = 18.0
                static let defaultMultiplier: CGFloat = 1.0
                static let leading: CGFloat = 10.0
                static let trailing: CGFloat = -10.0
            }
            
            static let error: String = "Could not load Label."
        }
    }
    
    // MARK: - Properties
    
    private lazy var label: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Label.Constraints.fontName, size: Constants.Label.Constraints.fontSize)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Public API
    
    static private(set) var height: CGFloat = 50.0
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    // MARK: - View Methods
    
    private func setupSubviews() {
        self.addSubview(label)
        
        addLabelConstraints()
    }
    
    private func addLabelConstraints() {
        guard let label = label else {
            fatalError(Constants.Label.error)
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: label,
                attribute: .leading,
                relatedBy: .equal,
                toItem: self,
                attribute: .leading,
                multiplier: Constants.Label.Constraints.defaultMultiplier,
                constant: Constants.Label.Constraints.leading),
            NSLayoutConstraint(
                item: label,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: self,
                attribute: .trailing,
                multiplier: Constants.Label.Constraints.defaultMultiplier,
                constant: Constants.Label.Constraints.trailing),
            NSLayoutConstraint(
                item: label,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: Constants.Label.Constraints.defaultMultiplier,
                constant: .zero),
        ])
    }
}
