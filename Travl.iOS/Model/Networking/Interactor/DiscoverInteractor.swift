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
    case images = "images"
}

final class DiscoverInteractor {
    private let networkManager = NetworkManager()
    
    func fetchLocations() async throws -> LocationsResponse {
        let location : LocationsResponse = try await networkManager.fetchData(endpoint: .location, queryString: "")
        return location
    }
    
    func fetchItenaries(_ location : String) async throws -> Itenaries {
        let itenaries : Itenaries = try await networkManager.fetchData(endpoint: .itenaries, queryString: location)
        return itenaries
    }
}

