//
//  DiscoverCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 11/08/2021.
//

import UIKit

@IBDesignable
final class DiscoverCell: UICollectionViewCell {
    
    @IBOutlet private weak var locationImage: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func cellContent(for location : Location) {
        locationImage.downloaded(from: location.image)
        locationImage.contentMode = .scaleAspectFill
        locationImage.layer.cornerRadius = 15
        locationLabel.text = location.locationName
    }
    
    func configureView() {
        
        contentView.contentMode = .scaleAspectFill
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        dropShadow()
    }
    
   
}
