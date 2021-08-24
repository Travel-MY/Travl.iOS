//
//  DiscoverCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 11/08/2021.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func cellContent(for location : Location) {
        locationImage.downloaded(from: location.image)
        locationImage.contentMode = .scaleAspectFill
        
        locationLabel.text = location.location_name
    }
    
    func configureCell() {
        locationImage.layer.cornerRadius = 15
//
//        contentView.layer.cornerRadius = 15
//        contentView.layer.borderWidth = 1.0
//        contentView.layer.borderColor = UIColor.clear.cgColor
//        contentView.layer.masksToBounds = true

//        layer.cornerRadius = 15
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 0.2)
//        layer.shadowRadius = 1
//        layer.shadowOpacity = 0.1
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
