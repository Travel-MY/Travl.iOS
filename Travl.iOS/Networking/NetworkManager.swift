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
    
    //MARK:- Locations
    func getLocations(for location: String = "locations", completed : @escaping (Result<[Location],TError>) -> Void) {
        
        var locationResponse : [Location] = []
        
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
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let locationDecode = try decoder.decode(LocationsResponse.self, from: safeData)
                
                for location in locationDecode.locations {
                    print( location.coordinate)
                    // print(location.id)
                    // print(location.image)
                    locationResponse.append(location)
                }
                completed(.success(locationResponse))
            } catch {
                completed(.failure(.invalidData))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //MARK:- Itenaries
    func getItenaries(for itenaries: String, completed : @escaping (Result<[[Days]],TError>) -> Void) {
        
        var itenaryResponse : [[Days]] = []
        
        let endpoint = baseNewsUrl + "itenaries-" + "\(itenaries)"
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
            
            //print(String(data: safeData, encoding: .utf8))
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let itenaries = try decoder.decode(Itenaries.self, from: safeData)
                
                for itenary in itenaries.itenaries.days {
                    itenaryResponse.append(itenary)
                    //print(itenary)
                }
                
                
                completed(.success(itenaryResponse))
            } catch {
                completed(.failure(.invalidData))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}



