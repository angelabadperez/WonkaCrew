//
//  CustomActivityIndicatorView.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 8/3/21.
//

import UIKit

class CustomActivityIndicatorView: UIView {
    
    // MARK: - Private Constants
    
    private enum Constants {
        enum Container {
            enum Constraints {
                static let alpha: CGFloat = 0.5
            }
            
            static let color: UIColor = .black
            static let error: String = "Could not load Container View."
        }
        
        enum Background {
            enum Constraints {
                static let defaultMultiplier: CGFloat = 1.0
                static let aspectRatio: CGFloat = 1.0
                static let width: CGFloat = 100.0
                static let alpha: CGFloat = 0.5
                static let cornerRadius: CGFloat = 15.0
            }
            
            static let color: String = "CharcoalColor"
            static let error: String = "Could not load Background View."
        }
        
        enum Image {
            enum Constraints {
                static let defaultMultiplier: CGFloat = 1.0
                static let width: CGFloat = 60.0
                static let aspectRatio: CGFloat = 1.0
            }
            
            static let name: String = "loading"
            static let error: String = "Could not load Activity Indicator Image View."
        }
    }
    
    // MARK: - Properties
    
    private lazy var containerView: UIView! = {
        let containerView = UIView(frame: UIScreen.main.bounds)
        containerView.backgroundColor = Constants.Container.color
        containerView.alpha = Constants.Container.Constraints.alpha
        containerView.isUserInteractionEnabled = false
        return containerView
    }()
    
    private lazy var backgroundView: UIView! = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: Constants.Background.color)
        backgroundView.alpha = Constants.Background.Constraints.alpha
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = Constants.Background.Constraints.cornerRadius
        return backgroundView
    }()
    
    private lazy var activityIndicatorImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.loadGif(name: Constants.Image.name)
        return imageView
    }()
    
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
        self.addSubview(containerView)
        containerView.addSubview(backgroundView)
        backgroundView.addSubview(activityIndicatorImageView)
        
        addBackgroundViewConstraints()
        addImageViewConstraints()
    }
    
    private func addBackgroundViewConstraints() {
        guard let backgroundView = backgroundView else {
            fatalError(Constants.Background.error)
        }
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: backgroundView,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Constants.Background.Constraints.defaultMultiplier,
                constant: Constants.Background.Constraints.width),
            NSLayoutConstraint(
                item: backgroundView,
                attribute: .height,
                relatedBy: .equal,
                toItem: backgroundView,
                attribute: .width,
                multiplier: Constants.Background.Constraints.aspectRatio,
                constant: .zero),
            NSLayoutConstraint(
                item: backgroundView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .centerX,
                multiplier: Constants.Background.Constraints.defaultMultiplier,
                constant: .zero),
            NSLayoutConstraint(
                item: backgroundView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .centerY,
                multiplier: Constants.Background.Constraints.defaultMultiplier,
                constant: .zero)
        ])
    }
    
    private func addImageViewConstraints() {
        guard let imageView = activityIndicatorImageView else {
            fatalError(Constants.Image.error)
        }
        
        activityIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: imageView,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Constants.Image.Constraints.defaultMultiplier,
                constant: Constants.Image.Constraints.width),
            NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: imageView,
                attribute: .width,
                multiplier: Constants.Image.Constraints.aspectRatio,
                constant: .zero),
            NSLayoutConstraint(
                item: imageView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: backgroundView,
                attribute: .centerX,
                multiplier: Constants.Image.Constraints.defaultMultiplier,
                constant: .zero),
            NSLayoutConstraint(
                item: imageView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: backgroundView,
                attribute: .centerY,
                multiplier: Constants.Image.Constraints.defaultMultiplier,
                constant: .zero)
            
        ])
    }
}
