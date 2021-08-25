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
   
    let id : Int
    let locationName : String
    let image : URL
    let slogan : String
    let description : String
    let coordinate : Coordinate
    
    enum CodingKeys : String, CodingKey {
        case id,image,slogan, description, coordinate
        case locationName = "location_name"
    }
}

struct Coordinate : Codable {
   
    let lon : Double
    let lat : Double
    
}
