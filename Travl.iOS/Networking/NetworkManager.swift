//
//  NetworkManager.swift
//  News+
//
//  Created by Ikmal Azman on 15/08/2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlSession = URLSession(configuration: .default)
    private let baseNewsUrl = "https://travl-api.herokuapp.com/"
    
    private var locationResponse : [Location] = []
    
    func getLocations(for location: String = "locations", completed : @escaping (Result<[Location],TError>) -> Void) {
        
        let endpoint = baseNewsUrl + "\(location)"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidTopic))
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let safeData = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let locationDecode = try decoder.decode(LocationsResponse.self, from: safeData)
                
                for location in locationDecode.locations {
                   // print(location.id)
                   // print(location.image)
                    self.locationResponse.append(location)
                }
                completed(.success(self.locationResponse))
            } catch {
                completed(.failure(.invalidData))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}



