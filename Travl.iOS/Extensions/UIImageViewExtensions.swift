//
//  UIImageExtensions.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 19/08/2021.
//

import UIKit.UIImageView
import Kingfisher

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImage(url: URL) {
        image = nil
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url) { [weak self]result in
            switch result {
            case .success(let response):
                self?.image = response.image
            case .failure(_):
                break
            }
        }
    }
}


