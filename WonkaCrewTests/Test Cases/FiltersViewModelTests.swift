//
//  FiltersViewModelTests.swift
//  WonkaCrewTests
//
//  Created by Ángel Abad Pérez on 11/3/21.
//

import XCTest
@testable import WonkaCrew

class FiltersViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: FiltersViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize View Model
        viewModel = FiltersViewModel(delegate: nil)
    }

    override func tearDownWithError() throws { }
    
    // MARK: - Tests

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Filters")
    }

    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 2)
    }
    
    func testNumberOfRowsForGenderSection() {
        XCTAssertEqual(viewModel.numberOfRows(for: FiltersViewModel.Sections.gender.rawValue), 2)
    }

    func testNumberOfRowsForProfessionsSection() {
        XCTAssertEqual(viewModel.numberOfRows(for: FiltersViewModel.Sections.profession.rawValue), 5)
    }
    
    func testHeaderForGender() {
        XCTAssertEqual(viewModel.header(for: FiltersViewModel.Sections.gender.rawValue), "Gender")
    }
    
    func testHeaderForProfessions() {
        XCTAssertEqual(viewModel.header(for: FiltersViewModel.Sections.profession.rawValue), "Profession")
    }
    
    func testViewModelForGenderIndexPath() {
        let filtersGenderViewModel = viewModel.viewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(filtersGenderViewModel as? FilterGenderViewModel)
    }
    
    func testViewModelForProfessionIndexPath() {
        let filtersGenderViewModel = viewModel.viewModel(for: IndexPath(row: 0, section: 1))
        XCTAssertNotNil(filtersGenderViewModel as? FilterProfessionViewModel)
    }

}
