//
//  AppCoordinator.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 8/3/21.
//

import UIKit
import Foundation

class AppCoordinator: Coordinator {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let wonkaColor: String = "WonkaColor"
    }
    
    // MARK: - Properties
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor(named: Constants.wonkaColor)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        return navigationController
    }()
    
    // MARK: - Public API
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Overrides
    
    override func start() {
        // Set navigation controller delegate
        navigationController.delegate = self
        
        // Show crew list
        showCrewList()
    }
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { childCoordinator in
            childCoordinator.navigationController(navigationController, willShow: viewController, animated: animated)
        }
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    // MARK: - Helper Methods
    
    private func showCrewList() {
        // Initialize Crew List View Controller
        let crewListViewController = CrewListViewController.instantiate()
        
        // Initialize Server Fetcher
        let serverFetcher = ServerFetcher()
        
        // Initialize Crew List View Model
        let viewModel = CrewListViewModel(serverFetcher: serverFetcher, delegate: crewListViewController)
        
        // Install handlers
        viewModel.didTapFilter = { [weak self] in
            self?.showFilters(from: viewModel)
        }
        
        viewModel.didSelectOompaLoompa = { [weak self] presentable in
            self?.showDetail(of: presentable)
        }
        
        viewModel.didGetError = { [weak self] errorText in
            self?.showErrorAlert(with: errorText)
        }
        
        // Configure Crew List View Controller
        crewListViewController.viewModel = viewModel
        
        // Push Crew List View Controller onto navigation stack
        navigationController.pushViewController(crewListViewController, animated: true)
    }
    
    private func showDetail(of presentable: OompaLoompaPresentable) {
        // Initialize Detail View Controller
        let detailViewController = DetailViewController.instantiate()
        
        // Configure Detail View Controller
        detailViewController.viewModel = presentable
        
        // Push Detail View Controller onto navigation stack
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func showErrorAlert(with error: String) {
        // Initialize Error Alert View Controller
        let errorAlertViewController = ErrorAlertViewController.instantiate()
        
        // Configure Error Alert View Controller
        errorAlertViewController.errorText = error
        
        // Install handlers
        errorAlertViewController.didTapClose = { [weak self] in
            self?.navigationController.dismiss(animated: true)
        }
        
        // Present Error Alert View Controller
        errorAlertViewController.modalPresentationStyle = .overCurrentContext
        errorAlertViewController.modalTransitionStyle = .crossDissolve
        navigationController.present(errorAlertViewController, animated: true)
    }
    
    private func showFilters(from delegate: FiltersViewModelDelegate) {
        // Initialize Filters View Controller
        let filtersViewController = FiltersViewController.instantiate()
        
        // Initialize Filters View Model
        var viewModel = FiltersViewModel(delegate: delegate)
        
        // Install handlers
        viewModel.didTapDone = { [weak self] in
            self?.navigationController.dismiss(animated: true)
        }
        
        // Configure Filters View Controller
        filtersViewController.viewModel = viewModel
        
        // Initialize a new Navigation Controller which root is the Filters View Controller
        let filtersNavigationController = UINavigationController(rootViewController: filtersViewController)
        
        // Configure the new Navigation Controller
        filtersNavigationController.navigationBar.barTintColor = UIColor(named: Constants.wonkaColor)
        filtersNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Present Filters View Controller
        navigationController.present(filtersNavigationController, animated: true)
    }
}
