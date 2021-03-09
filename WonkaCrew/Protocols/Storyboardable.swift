//
//  Storyboardable.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 8/3/21.
//

import UIKit

// MARK: - Private constants

fileprivate enum Constants {
    static let defaultStoryboard: String = "Main"
    static let instantiationErrorMessage: String = "Unable to Instantiate View Controller With Storyboard Identifier"
}

protocol Storyboardable {
    
    // MARK: - Properties
    
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var storyboardIdentifier: String { get }
    
    // MARK: - Methods
    
    static func instantiate() -> Self
    
}

extension Storyboardable where Self: UIViewController {
    
    // MARK: - Properties
    
    static var storyboardName: String {
        return Constants.defaultStoryboard
    }
    
    static var storyboardBundle: Bundle {
        return .main
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Methods
    
    static func instantiate() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: storyboardBundle).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("\(Constants.instantiationErrorMessage) \(storyboardIdentifier)")
        }
        
        return viewController
    }
    
}
