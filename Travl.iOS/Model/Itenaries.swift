//
//  Intenaries.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/08/2021.
//

import Foundation

struct Itenaries : Codable {
    let itenaries : Itenary
}

struct Itenary : Codable {
    var days : [[Days]]
}

struct Days : Codable {
    
    let locationName : String
    let description : String
    let image : URL
    let website : String
    let phoneNumber : String
    let coordinate : Coordinate
    let address: String
    let state : String
    let postcode : String
    
    enum CodingKeys : String, CodingKey {
        case website,address,state,postcode
        
        case  locationName = "itenary_location_name"
        case  description =  "itenary_description"
        case  image = "itenary_image"
        case  coordinate  = "itenary_coordinate"
        case  phoneNumber = "phone_number"
    }
}
