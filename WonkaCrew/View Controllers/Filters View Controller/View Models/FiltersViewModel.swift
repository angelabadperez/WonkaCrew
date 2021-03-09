//
//  FiltersViewModel.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import Foundation

protocol FiltersViewModelDelegate: AnyObject {
    func didChangeFilter()
}

struct FiltersViewModel {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let title: String = "Filters"
        static let indexPathError: String = "Unexpected IndexPath."
        static let indexError: String = "Unexpected index."
    }
    
    // MARK: - Properties
    
    enum Sections: Int, CaseIterable {
        
        // MARK: - Private constants
        
        private enum Constants {
            static let gender: String = "Gender"
            static let profession: String = "Profession"
        }
        
        // MARK: - Enum cases
        
        case gender
        case profession
        
        // MARK: - Public API
        
        var numberOfRows: Int {
            switch self {
            case .gender: return Gender.allCases.count
            case .profession: return Profession.allCases.count
            }
        }
        
        var header: String {
            switch self {
            case .gender: return Constants.gender
            case .profession: return Constants.profession
            }
        }
    }
    
    private weak var delegate: FiltersViewModelDelegate?
    
    // MARK: - Initialization
    
    init(delegate: FiltersViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Public API
    
    var didTapDone: (() -> Void)?
    
    var title: String {
        return Constants.title
    }
    
    var numberOfSections: Int {
        return Sections.allCases.count
    }
    
    func numberOfRows(for index: Int) -> Int {
        return section(for: index).numberOfRows
    }
    
    func header(for index: Int) -> String {
        return section(for: index).header
    }
    
    func viewModel(for indexPath: IndexPath) -> FiltersPresentable {
        switch section(for: indexPath.section) {
        case .gender:
            guard let gender = Gender(rawValue: indexPath.row) else {
                fatalError(Constants.indexPathError)
            }
            return FilterGenderViewModel(gender: gender)
        case .profession:
            guard let profession = Profession(rawValue: indexPath.row) else {
                fatalError(Constants.indexPathError)
            }
            return FilterProfessionViewModel(profession: profession)
        }
    }
    
    func tapDone() {
        didTapDone?()
    }
    
    func changedFilter() {
        delegate?.didChangeFilter()
    }
    
    // MARK: - Private methods
    
    private func section(for index: Int) -> Sections {
        guard let section = Sections(rawValue: index) else {
            fatalError(Constants.indexError)
        }
        return section
    }
}
