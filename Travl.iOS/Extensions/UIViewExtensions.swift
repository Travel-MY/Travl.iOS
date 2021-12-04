//
//  UIViewExtensions.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 29/08/2021.
//

import UIKit.UIView
import CoreGraphics

extension UIView {
    
   /// Get nib file name and return to first UIView
    func loadViewFromNib(nibName : String) -> UIView? {
        // Get bundle , to find class in which library
        let bundle = Bundle(for: type(of: self))
        // Create instance of UINib
        let nib = UINib(nibName: nibName, bundle: bundle)
        // Inatiate and get first object from array and cast to UIView
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
  }
    
    /// Add drop down shadow to view
    func dropShadow(scale: Bool = true, radius: CGFloat = 2, opacity : Float = 0.2) {
           layer.masksToBounds = false
           layer.shadowColor = UIColor.lightGray.cgColor
           layer.shadowOpacity = opacity
           layer.shadowOffset = CGSize(width: -1, height: 1)
           layer.shadowRadius = radius
           
           let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
           layer.shadowPath = shadowPath.cgPath
           layer.shouldRasterize = true
           layer.rasterizationScale = scale ? UIScreen.main.scale : 1
       }
    
    func addRoundedCorners(radius : CGFloat = 15) {
        layer.cornerRadius = radius
    }
    
    func addCellPadding(top : CGFloat, left : CGFloat = 20, bottom : CGFloat = 10, right : CGFloat = 20) {
        let padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        frame = frame.inset(by: padding)
    }

    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
