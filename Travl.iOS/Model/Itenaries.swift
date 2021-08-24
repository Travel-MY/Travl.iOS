//
//  Intenaries.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/08/2021.
//

import Foundation

struct Itenaries : Codable {
    enum CodingKeys : String,CodingKey {
        case itenaries
    }
    let itenaries : Itenary
}

struct Itenary : Codable {
    var days : [[Days]]
}

struct Days : Codable {
    enum CodingKeys : String, CodingKey {
        case website,address,state,postcode
        
        case itenary_location_name = "locationName"
        case itenary_description = "description"
        case itenary_image = "image"
        case itenary_coordinate = "coordinate"
        case phone_number = "phone_number"
    }
    let itenary_location_name : String
    let itenary_description : String
    let itenary_image : URL
    let website : URL
    let phone_number : String
    let itenary_coordinate : Coordinate
    let address: String
    let state : String
    let postcode : String
}
