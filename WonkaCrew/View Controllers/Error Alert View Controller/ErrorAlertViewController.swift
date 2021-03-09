//
//  ErrorAlertViewController.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import UIKit

class ErrorAlertViewController: UIViewController, Storyboardable {
    
    // MARK: - Private constants
    
    private enum Constants {
        enum Constraints {
            static let cornerRadius: CGFloat = 15.0
        }
        
        static let noError: String = "No error message."
    }

    // MARK: - Properties
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak private var errorTextLabel: UILabel!
    
    var didTapClose: (() -> Void)?
    var errorText: String?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        // Set rounded border to Alert View
        alertView.layer.cornerRadius = Constants.Constraints.cornerRadius
        
        // Set error message to Error Text Label
        errorTextLabel.text = errorText ?? Constants.noError
    }

    // MARK: - Actions
    
    @IBAction func closeTapped(_ sender: Any) {
        didTapClose?()
    }
}
