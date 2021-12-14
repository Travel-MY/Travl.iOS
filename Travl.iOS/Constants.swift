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
    static var accessManageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


extension UIColor {
    static let primarySeaBlue = UIColor(hex: "0077B6")!
    static let secondaryLightTurqoise = UIColor(hex: "00B4D8")!
    static let headingBlackLabel = UIColor.black
    static let subtitleGrayLabel = UIColor(hex: "808080")!
}
