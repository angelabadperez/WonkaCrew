//
//  Coordinator.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 8/3/21.
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    var didFinish: ((Coordinator) -> Void)?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Methods
    
    func start() {}
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {}
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    
    func pushCoordinator(_ coordinator: Coordinator) {
        // Install handler
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }
        
        // Start coordinator
        coordinator.start()
        
        // Append to child coordinators array
        childCoordinators.append(coordinator)
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        // Remove coordinator from child coordinators
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
}

