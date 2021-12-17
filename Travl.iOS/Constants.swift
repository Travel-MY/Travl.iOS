//
//  Constants.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 31/08/2021.
//

import UIKit

struct Constants {
    struct Device {
        static var height : CGFloat {
            return UIScreen.main.bounds.height
        }
        static var width : CGFloat {
            return UIScreen.main.bounds.width
        }
    }
    struct SegueIdentifier {
        static let goToCreatePlanner = "goToCreatePlanner"
        static let goToPlannerDetails = "goToPlannerDetails"
        static let goToALDetails = "goToALDetails"
        static let goToTourMenu = "goToTourMenu"
    }
    struct UserDefautlsKey {
        static let primaryKeyForPlanner = "parentPlanner"
        static let parentStartDate = "parentStartDate"
        static let parentEndDate = "parentEndDate"
    }
    static var accessManageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


extension UIColor {
    static let primarySeaBlue = UIColor(hex: "0077B6")!
    static let secondaryLightTurqoise = UIColor(hex: "00B4D8")!
    static let headingBlackLabel = UIColor.black
    static let subtitleGrayLabel = UIColor(hex: "808080")!
}
