//
//  FilterProfessionViewModelTests.swift
//  WonkaCrewTests
//
//  Created by Ángel Abad Pérez on 11/3/21.
//

import XCTest
@testable import WonkaCrew

class FilterProfessionViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: FilterProfessionViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Filters View Model
        let filtersViewModel = FiltersViewModel(delegate: nil)
        
        // Initialize Filter Gender View Model
        viewModel = filtersViewModel.viewModel(for: IndexPath(row: 0, section: 1)) as? FilterProfessionViewModel
    }
    
    override func tearDownWithError() throws {
        // Reset UserDefaults. It is necessary to do it this way.
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.professions)
    }
    
    // MARK: - Tests
    
    func testText() {
        XCTAssertEqual(viewModel.text, "Developer")
    }
    
    func testSelect() {
        viewModel.select()
        XCTAssertTrue(viewModel.selected)
    }
    
    func testDeselect() {
        viewModel.select()
        viewModel.select()
        XCTAssertFalse(viewModel.selected)
    }
    
}
