//
//  CrewListViewModel.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

protocol CrewListViewModelDelegate: AnyObject {
    func reloadData()
}

final class CrewListViewModel {
    
    // MARK: - Properties
    
    weak var delegate: CrewListViewModelDelegate?
    var serverFetcher: ServerFetcherType
    
    private var allCrewList: [OompaLoompa]
    private var error: ServerFetcherError?
    private var page: Int = 1
    private var isLoading: Bool = false
    
    private var filter: [(OompaLoompa) -> Bool]? = []
    
    private var filteredCrewList: [OompaLoompa] {
        guard let filter = filter, !filter.isEmpty else { return allCrewList }
        return allCrewList
            .filter { oompaLoompa in
                return filter.reduce(true) { isMatch, condition in
                    return isMatch && condition(oompaLoompa)
                }
            }
    }
    
    // MARK: - Initialization
    
    init(serverFetcher: ServerFetcherType, delegate: CrewListViewModelDelegate) {
        self.serverFetcher = serverFetcher
        self.delegate = delegate
        self.allCrewList = []
        
        // Fetch data
        fetchCrewList()
    }
    
    // MARK: - Public API
    
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
    
    // MARK: - Private methods
    
    func fetchCrewList() {
        guard !isLoading else { return }
        
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
            self.delegate?.reloadData()
        }
        
    }
}
