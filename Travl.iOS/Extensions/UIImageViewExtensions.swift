//
//  UIImageExtensions.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 19/08/2021.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    
    func loadImage(url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(named: "image-1"), options: [.transition(.fade(0.1)), .cacheOriginalImage])
    }
}
