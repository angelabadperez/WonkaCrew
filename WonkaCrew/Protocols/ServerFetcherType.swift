//
//  ServerFetcherType.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

enum ServerFetcherError: LocalizedError {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let invalidResponseError: String = "The server response is invalid."
        static let failedRequest: String = "The request has failed."
        static let unknownError: String = "An unknown error has occurred."
    }
    
    // MARK: - Enum cases
    
    case failedRequest
    case invalidResponse
    case unknown
    
    // MARK: - Public API
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return Constants.invalidResponseError
        case .failedRequest: return Constants.failedRequest
        case .unknown: return Constants.unknownError
        }
    }
}

protocol ServerFetcherType {
    
    // MARK: - Type Aliases
    
    typealias CrewListResult = (Result<CrewList, ServerFetcherError>) -> Void
    
    // MARK: - Methods
    
    func getCrewList(page: Int, completion: @escaping CrewListResult)
}
