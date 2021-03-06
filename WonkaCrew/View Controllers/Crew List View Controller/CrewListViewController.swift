//
//  CrewListViewController.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import UIKit

class CrewListViewController: UIViewController, Storyboardable {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let filterIcon: String = "filter"
        static let dequeueCellErrorMessage: String = "Unable to Dequeue Oompa Loompa Table View Cell"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var activityIndicator: CustomActivityIndicatorView! = {
        let activityIndicator = CustomActivityIndicatorView(frame: self.view.bounds)
        return activityIndicator
    }()
    
    var viewModel: CrewListViewModel?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        // Add loading activity indicator until data is fetched
        activityIndicator.isHidden = false
        navigationController?.view.addSubview(activityIndicator)
        
        setupBar()
        setupTableView()
    }
    
    private func updateView() {
        tableView.isHidden = false
        activityIndicator.isHidden = true
        tableView.reloadData()
    }
    
    private func setupBar() {
        guard let filterIcon = UIImage(named: Constants.filterIcon) else { return }
        
        let filterItem = UIBarButtonItem(image: filterIcon, style: .plain, target: self, action: #selector(filterTapped))
        filterItem.tintColor = .white
        navigationItem.setRightBarButton(filterItem, animated: false)
        
        // Setup title
        title = viewModel?.title
    }
    
    private func setupTableView() {
        // Hide table view
        tableView.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Helper methods
    
    private func scrollToTop() {
        guard let viewModel = viewModel,
              viewModel.numberOfCrew > 0 else { return }
        tableView.scrollToRow(at: IndexPath(row: .zero, section: .zero), at: .top, animated: true)
    }
    
    private func setEmptyTableView() {
        // Initialize Empty Table View
        let emptyTableView = EmptyTableView()
        
        // Install handler
        emptyTableView.didTapTryAgain = { [weak self] in
            self?.viewModel?.fetchCrewList()
        }
        
        // Set Empty Table View
        tableView.setEmptyView(emptyTableView)
    }
    
    // MARK: - Actions
    
    @objc private func filterTapped() {
        viewModel?.tapFilter()
    }
}

// MARK: - ViewModel Delegate

extension CrewListViewController: CrewListViewModelDelegate {
    func didFetchData() {
        updateView()
    }
    
    func didChangeFilter() {
        updateView()
        scrollToTop()
    }
}

// MARK: - TableView DataSource

extension CrewListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        let numberOfRows = viewModel.numberOfCrew
        
        if numberOfRows == .zero {
            setEmptyTableView()
        } else {
            tableView.restore()
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OompaLoompaTableViewCell.self), for: indexPath) as? OompaLoompaTableViewCell,
              let viewModel = viewModel else {
            fatalError(Constants.dequeueCellErrorMessage)
        }
        
        if let viewModel = viewModel.viewModel(for: indexPath.row) {
            cell.configure(with: viewModel)
        }
        
        if indexPath.row == viewModel.numberOfCrew - 1 {
            viewModel.fetchCrewList()
        }
        
        return cell
    }
}

// MARK: - TableView Delegate

extension CrewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.selectOompaLoompa(at: indexPath.row)
    }
}
