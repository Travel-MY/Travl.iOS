//
//  ItenaryCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 27/08/2021.
//

import UIKit

final class ItenaryCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.headerLabel.text = nil
        self.descLabel.text = nil
        self.iconImage.image = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.textColor = .headingBlackLabel
        descLabel.textColor = .subtitleGrayLabel
        iconImage.addRoundedCorners()
    }
    
    func cellContent(for itenary : Days) {
        headerLabel.text = itenary.locationName
        descLabel.text = itenary.description
        iconImage.loadImage(url: itenary.image)
    }

}
