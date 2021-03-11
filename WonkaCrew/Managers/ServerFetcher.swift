//
//  ServerFetcher.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 7/3/21.
//

import Foundation

final class ServerFetcher: ServerFetcherType {
    
    // MARK: - Public API
    
    func getCrewList(page: Int, completion: @escaping CrewListResult) {
        // Create URL
        let url = APIConfiguration.init(page: page).url
        
        // Create datatask
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.didFetchCrewList(data: data, response: response, error: error, completion: completion)
            }
        }.resume()
    }
    
    // MARK: - Helper methods
    
    private func didFetchCrewList(data: Data?, response: URLResponse?, error: Error?, completion: CrewListResult) {
        if error != nil {
            completion(.failure(.failedRequest))
        } else if let data = data,
                  let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let crewList = try decoder.decode(CrewList.self, from: data)
                    completion(.success(crewList))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            } else {
                completion(.failure(.failedRequest))
            }
        } else {
            completion(.failure(.unknown))
        }
    }
}
