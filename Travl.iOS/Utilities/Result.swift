//
//  Result.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 17/08/2021.
//

import Foundation

enum Result<Success, Failure : Error> {
    
    case success(Success)
    case failure(Failure)
}
