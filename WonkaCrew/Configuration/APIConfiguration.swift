//
//  APIConfiguration.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

struct APIConfiguration {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let baseUrl: String = "https://2q2woep105.execute-api.eu-west-1.amazonaws.com/napptilus/oompa-loompas"
        static let page: String = "page"
        static let urlErrorMessage: String = "Unable to create URL"
    }
    
    // MARK: - Properties
    
    private let baseUrl = URL(string: Constants.baseUrl)
    
    // MARK: -
    
    let page: Int
    
    // MARK: - Public API
    
    var url: URL {
        // Create URL components
        guard let baseUrl = baseUrl,
              var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            fatalError(Constants.urlErrorMessage)
        }
        
        // Add query items
        components.queryItems = [
            URLQueryItem(name: Constants.page, value: "\(page)")
        ]
        
        // Get URL
        guard let url = components.url else {
            fatalError(Constants.urlErrorMessage)
        }
        
        return url
    }
}
