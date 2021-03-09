//
//  FiltersViewController.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 8/3/21.
//

import UIKit

class FiltersViewController: UIViewController, Storyboardable {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let done: String = "Done"
        static let dequeueCellErrorMessage: String = "Unable to Dequeue Filters Table View Cell"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FiltersViewModel?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupBar()
        setupTableView()
    }
    
    private func setupBar() {
        let doneItem = UIBarButtonItem(title: Constants.done, style: .plain, target: self, action: #selector(doneTapped))
        doneItem.tintColor = .white
        navigationItem.setRightBarButton(doneItem, animated: false)
        
        // Setup title
        title = viewModel?.title
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.separatorInset = .zero
        tableView.alwaysBounceVertical = false
    }
    
    // MARK: - Actions
    
    @objc func doneTapped() {
        viewModel?.tapDone()
    }
}

// MARK: - TableView DataSource

extension FiltersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FiltersTableViewCell.self), for: indexPath) as? FiltersTableViewCell else {
            fatalError(Constants.dequeueCellErrorMessage)
        }
        
        if let viewModel = viewModel?.viewModel(for: indexPath) {
            cell.configure(with: viewModel)
        }
        
        return cell
    }
}

// MARK: - TableView Delegate

extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let filtersHeader = FiltersHeaderView(frame: CGRect(x: .zero,
                                                            y: .zero,
                                                            width: tableView.frame.width,
                                                            height: FiltersHeaderView.height))
        filtersHeader.text = viewModel?.header(for: section)
        return filtersHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FiltersHeaderView.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let childViewModel = viewModel?.viewModel(for: indexPath) {
            childViewModel.select()
            viewModel?.changedFilter()
        }
        
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
}
