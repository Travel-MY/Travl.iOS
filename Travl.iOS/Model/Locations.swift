//
//  Location.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 19/08/2021.
//

import Foundation

struct LocationsResponse : Codable {
    let locations : [Location]
}

struct Location : Codable {
    enum CodingKeys : String, CodingKey {
        case id,image,slogan, description, coordinate
        case location_name = "locationName"
    }
    let id : Int
    let location_name : String
    let image : URL
    let slogan : String
    let description : String
    let coordinate : Coordinate
}

struct Coordinate : Codable {

    let lon : Double
    let lat : Double
}
