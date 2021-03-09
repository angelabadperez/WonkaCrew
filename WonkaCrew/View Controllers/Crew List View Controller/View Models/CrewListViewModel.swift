//
//  CrewListViewModel.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

protocol CrewListViewModelDelegate: AnyObject {
    func didFetchData()
    func didChangeFilter()
}

final class CrewListViewModel {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let title: String = "Crew List"
        // Set here manually because the server always returns data, even if we set an invalid page (> 20).
        static let maxPage: Int = 20
    }
    
    // MARK: - Properties
    
    weak private var delegate: CrewListViewModelDelegate?
    
    private var serverFetcher: ServerFetcherType
    
    private var allCrewList: [OompaLoompa]
    private var error: ServerFetcherError?
    private var page: Int = 1
    private var isLoading: Bool = false
    private var filter: (Gender?, [Profession]) = (nil, [])
    
    private var filteredCrewList: [OompaLoompa] {
        if filter.0 == nil && filter.1.isEmpty {
            return allCrewList
        }
        
        return allCrewList
            .filter {
                var matches = true
                
                // Filter by gender (if selected)
                if let genderFilter = filter.0 {
                    matches = genderFilter == $0.gender
                }
                
                // Filter by profession(s) (if selected)
                let professionFilter = filter.1
                if !professionFilter.isEmpty {
                    matches = matches && filter.1.contains($0.profession)
                }
                
                return matches
            }
    }
    
    // MARK: - Initialization
    
    init(serverFetcher: ServerFetcherType, delegate: CrewListViewModelDelegate) {
        self.serverFetcher = serverFetcher
        self.delegate = delegate
        self.allCrewList = []
        
        // Set initial filter
        refreshFilter()
        
        // Fetch data
        fetchCrewList()
    }
    
    // MARK: - Public API
    
    var didTapFilter: (() -> Void)?
    
    var title: String {
        return Constants.title
    }
    
    var errorMessage: String {
        return error?.errorDescription ?? ""
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfCrew: Int {
        return filteredCrewList.count
    }
    
    func viewModel(for index: Int) -> OompaLoompaViewModel? {
        return OompaLoompaViewModel(oompaLoompa: filteredCrewList[index])
    }
    
    func tapFilter() {
        didTapFilter?()
    }
    
    func fetchCrewList() {
        guard !isLoading,
              page <= Constants.maxPage else { return }
        
        isLoading = true
        
        serverFetcher.getCrewList(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let crew):
                self.allCrewList.append(contentsOf: crew.results)
            case .failure(let error):
                self.error = error
            }
            
            self.page += 1
            self.isLoading = false
            self.delegate?.didFetchData()
        }
    }
    
    // MARK: - Private methods
    
    private func refreshFilter() {
        filter = (nil, [])
        filter.0 = UserDefaults.gender
        filter.1 = UserDefaults.professions
    }
}

extension CrewListViewModel: FiltersViewModelDelegate {
    func didChangeFilter() {
        // Refresh filter
        refreshFilter()
        
        // Reload view controller's data
        delegate?.didChangeFilter()
    }
}
