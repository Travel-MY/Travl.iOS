//
//  UIAlertAction+Extensions.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 18/12/2021.
//

import UIKit

enum FailureEvent : String {
    case DatabaseConnection = "Database Connection"
    case InternetConnection = "Internet Connection"
}
extension UIAlertController {
    func createDefaultAlertForFailure(_ title : FailureEvent = .InternetConnection, message : String) -> UIAlertController {
        let alert = UIAlertController(title: title.rawValue, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in }
        alert.addAction(action)
        return alert
    }
}

