//
//  EmptyTableView.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import UIKit

class EmptyTableView: UIView {
    
    // MARK: - Private constants
    
    private enum Constants {
        enum StackView {
            enum Constraints {
                static let spacing: CGFloat = 10.0
                static let leading: CGFloat = 10.0
                static let trailing: CGFloat = -10.0
                static let defaultMultiplier: CGFloat = 1.0
            }
            static let error: String = "Could not load Stack View."
        }
        
        enum Image {
            enum Constraints {
                static let side: CGFloat = 100.0
            }
            
            static let name = "emptyResults"
        }
        
        enum Label {
            enum Constraints {
                static let fontName: String = "EuphemiaUCAS-Bold"
                static let fontSize: CGFloat = 18.0
            }
            
            static let text = "Whoops! It seems that no results have been found."
        }
        
        enum Button {
            enum Constraints {
                static let fontSize: CGFloat = 20.0
            }
            
            static let text: String = "Try Again"
        }
    }
    
    // MARK: - Properties
    
    private lazy var iconImageView: UIImageView! = {
        let imageView = UIImageView(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: Constants.Image.Constraints.side,
                                                  height: Constants.Image.Constraints.side))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Image.name)
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel! = {
        let label = UILabel()
        label.text = Constants.Label.text
        label.font = UIFont(name: Constants.Label.Constraints.fontName, size: Constants.Label.Constraints.fontSize)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tryAgainButton: UIButton! = {
        let button = UIButton()
        button.setTitle(Constants.Button.text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.Button.Constraints.fontSize)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.StackView.Constraints.spacing
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(emptyLabel)
        stackView.addArrangedSubview(tryAgainButton)
        return stackView
    }()
    
    var didTapTryAgain: (() -> Void)?
    
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
        self.addSubview(stackView)
        
        addStackViewConstraints()
    }
    
    private func addStackViewConstraints() {
        guard let stackView = stackView else {
            fatalError(Constants.StackView.error)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: stackView,
                attribute: .leading,
                relatedBy: .equal,
                toItem: self,
                attribute: .leading,
                multiplier: Constants.StackView.Constraints.defaultMultiplier,
                constant: Constants.StackView.Constraints.leading),
            NSLayoutConstraint(
                item: stackView,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: self,
                attribute: .trailing,
                multiplier: Constants.StackView.Constraints.defaultMultiplier,
                constant: Constants.StackView.Constraints.trailing),
            NSLayoutConstraint(
                item: stackView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: Constants.StackView.Constraints.defaultMultiplier,
                constant: .zero)
        ])
    }
    
    // MARK: - Actions
    
    @objc func tryAgainTapped() {
        didTapTryAgain?()
    }
    
}
