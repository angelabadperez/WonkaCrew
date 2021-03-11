//
//  OompaLoompaViewModelTests.swift
//  WonkaCrewTests
//
//  Created by Ángel Abad Pérez on 11/3/21.
//

import XCTest
import Kingfisher
@testable import WonkaCrew

class OompaLoompaViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: OompaLoompaViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Mock ServerFetcher
        let mockServerFetcher = MockServerFetcher()
        
        // Initialize Crew List View Model and Fetch Data
        let crewListViewModel = CrewListViewModel(serverFetcher: mockServerFetcher, delegate: nil)
        
        // Get Oompa Loompa
        let oompaLoompa = crewListViewModel.viewModel(for: 7)!.oompaLoompa
        
        // Initialize Oompa Loompa View Model
        viewModel = OompaLoompaViewModel(oompaLoompa: oompaLoompa)
    }

    override func tearDownWithError() throws {
        // Reset UserDefaults. It is necessary to do it this way.
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.gender)
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.professions)
    }

    // MARK: - Tests
    
    func testFullName() {
        XCTAssertEqual(viewModel.fullName, "Kelsy Paramor")
    }
    
    func testProfession() {
        XCTAssertEqual(viewModel.profession, "Medic")
    }
    
    func testGender() {
        XCTAssertEqual(viewModel.gender, "Male")
    }
    
    func testEmail() {
        XCTAssertEqual(viewModel.email, "kparamor8@visualengin.com")
    }
    
    func testCountry() {
        XCTAssertEqual(viewModel.country, "Loompalandia")
    }
    
    func testAge() {
        XCTAssertEqual(viewModel.age, 23)
    }
    
    func testHeight() {
        XCTAssertEqual(viewModel.height, 95)
    }
    
    func testColor() {
        XCTAssertEqual(viewModel.color, "Blue")
    }
    
    func testFood() {
        XCTAssertEqual(viewModel.food, "Cocoa Nuts")
    }
    
    func testSong() {
        // It is easier to check the string count.
        XCTAssertEqual(viewModel.song.count, 3041)
    }
    
    func testImage() {
        // Check if both URL strings are equal
        XCTAssertEqual(viewModel.image, "https://s3.eu-central-1.amazonaws.com/napptilus/level-test/8.jpg")
    }
}
