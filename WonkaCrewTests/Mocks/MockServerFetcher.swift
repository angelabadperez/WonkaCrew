//
//  MockServerFetcher.swift
//  WonkaCrewTests
//
//  Created by Ángel Abad Pérez on 11/3/21.
//

import Foundation
@testable import WonkaCrew

class MockServerFetcher: ServerFetcherType {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let stubName: String = "crewList"
        static let stubExtension: String = "json"
    }
    
    // MARK: - Public API
    
    func getCrewList(page: Int, completion: @escaping CrewListResult) {
        // Get data from stub
        guard let data = loadStub(name: Constants.stubName, extension: Constants.stubExtension) else {
            completion(.failure(.unknown))
            return
        }
        
        // Create JSON decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            // Decode JSON
            let crewList = try decoder.decode(CrewList.self, from: data)
            
            completion(.success(crewList))
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - Helper Methods
    
    private func loadStub(name: String, extension: String) -> Data? {
        // Obtain reference to Bundle
        let bundle = Bundle(for: type(of: self))
        
        // Ask Bundle for URL of stub
        guard let url = bundle.url(forResource: name, withExtension: `extension`) else {
            return nil
        }
        
        // Use URL to create data object
        return try? Data(contentsOf: url)
    }
}
