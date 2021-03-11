//
//  CrewListViewModelTests.swift
//  WonkaCrewTests
//
//  Created by Ángel Abad Pérez on 11/3/21.
//

import XCTest
@testable import WonkaCrew

class CrewListViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: CrewListViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Mock ServerFetcher
        let mockServerFetcher = MockServerFetcher()
        
        // Initialize View Model
        viewModel = CrewListViewModel(serverFetcher: mockServerFetcher, delegate: nil)
    }

    override func tearDownWithError() throws {
        // Reset UserDefaults. It is necessary to do it this way.
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.gender)
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.professions)
    }

    // MARK: - Tests
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Crew List")
    }

    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testNumberOfCrewWithoutFilters() {
        XCTAssertEqual(viewModel.numberOfCrew, 25)
    }
    
    func testNumberOfCrewMetalworker() {
        // It is necessary to do it this way.
        UserDefaults.standard.set([Profession.metalworker.rawValue], forKey: UserDefaults.Keys.professions)
        viewModel.didChangeFilter()
        XCTAssertEqual(viewModel.numberOfCrew, 6)
    }
    
    func testNumberOfCrewFemale() {
        // It is necessary to do it this way.
        UserDefaults.standard.set(Gender.female.rawValue, forKey: UserDefaults.Keys.gender)
        viewModel.didChangeFilter()
        XCTAssertEqual(viewModel.numberOfCrew, 10)
    }
    
    func testNumberOfCrewFemaleAndMetalworker() {
        // It is necessary to do it this way.
        UserDefaults.standard.set(Gender.female.rawValue, forKey: UserDefaults.Keys.gender)
        UserDefaults.standard.set([Profession.metalworker.rawValue], forKey: UserDefaults.Keys.professions)
        viewModel.didChangeFilter()
        XCTAssertEqual(viewModel.numberOfCrew, 1)
    }
    
    func testNumberOfCrewFemaleMetalworkerAndMedic() {
        // It is necessary to do it this way.
        UserDefaults.standard.set(Gender.female.rawValue, forKey: UserDefaults.Keys.gender)
        UserDefaults.standard.set([Profession.metalworker.rawValue, Profession.medic.rawValue], forKey: UserDefaults.Keys.professions)
        viewModel.didChangeFilter()
        XCTAssertEqual(viewModel.numberOfCrew, 3)
    }
    
    func testNumberOfCrewDeveloperAndBrewer() {
        // It is necessary to do it this way.
        UserDefaults.standard.set([Profession.developer.rawValue, Profession.brewer.rawValue], forKey: UserDefaults.Keys.professions)
        viewModel.didChangeFilter()
        XCTAssertEqual(viewModel.numberOfCrew, 11)
    }
    
    func testFetchSecondPage() {
        viewModel.fetchCrewList()
        XCTAssertEqual(viewModel.numberOfCrew, 50)
    }
    
    func testViewModelForIndex() {
        let oompaLoompaViewModel = viewModel.viewModel(for: 4)
        XCTAssertEqual(oompaLoompaViewModel?.fullName, "Cassius Twamley")
        XCTAssertEqual(oompaLoompaViewModel?.profession, "Developer")
    }
}
