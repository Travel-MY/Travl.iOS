//
//  NetworkManager.swift
//  News+
//
//  Created by Ikmal Azman on 15/08/2021.
//

import Foundation

final class NetworkManager {
    
    private let baseURL = "https://travl-api.herokuapp.com/"
    
    //MARK: - Generic Decoded Methods
    func fetchData<T:Decodable>(endpoint : Endpoint, queryString query: String) async throws -> T {
        
        let urlString = ( baseURL + "\(endpoint.rawValue)" + query).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        guard let url = URL(string: urlString) else {
            throw TError.invalidTopic
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw TError.invalidData
        }
    }
}

/// Extend backward compatibility for URLSession Async API
extension URLSession {
    /// Although Swift 5.5’s new concurrency system is becoming backward compatible in Xcode 13.2,
    /// some of the built-in system APIs that make use of these new concurrency features are still only available on iOS 15, macOS Monterey, and the rest of Apple’s 2021 operating systems.
    @available(iOS, deprecated: 15.0, message: "Use this built in API instead")
    func data(from url : URL) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation({ continuation in
            let dataTask = self.dataTask(with: url) { data, response, error in
                if let error = error {
                    return continuation.resume(throwing: error)
                }
                
                guard let data = data,
                      let response = response as? HTTPURLResponse ,
                      response.statusCode == 200 else {
                    return continuation.resume(throwing: TError.invalidData)
                }
                continuation.resume(returning: (data, response))
            }
            dataTask.resume()
        })
    }
}



