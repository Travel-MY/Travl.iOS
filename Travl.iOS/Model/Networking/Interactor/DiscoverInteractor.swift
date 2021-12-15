//
//  DiscoverInteractor.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 15/12/2021.
//

import Foundation

enum Endpoint : String {
    case location = "locations"
    case itenaries = "itenaries-"
}

final class DiscoverInteractor {
    private let networkManager = NetworkManager()
    
    func fetchLocations(completion : @escaping ((Result<LocationsResponse,TError>)->Void)) {
        networkManager.fetchData(endpoint: .location) {  (_ result : Result<LocationsResponse, TError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.invalidData))
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func fetchItenaries(_ location : String, completion : @escaping ((Result<[[Days]],TError>)-> Void)) {
        networkManager.fetchData(endpoint: .itenaries, queryString: location) { (_ result : Result<Itenaries, TError>) in
            var itenaryCollection = [[Days]]()
            switch result {
            case .success(let data):
                print(data)
                for itenaryPerDays in data.itenaries.days {
                    itenaryCollection.append(itenaryPerDays)
                }
                completion(.success(itenaryCollection))
            case .failure(let error):
                completion(.failure(.invalidData))
                print("Error : \(error.localizedDescription)")
            }
        }
    }
}
