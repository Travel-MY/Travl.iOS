//
//  Images.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 16/12/2021.
//

import Foundation

struct ImagesResponse : Decodable {
    let images : [Images]
}
struct Images : Decodable {
    let id : Int
    let imageURL : URL
    
    enum CodingKeys : String, CodingKey {
        case id = "image_id"
        case imageURL = "image_link"
    }
}
