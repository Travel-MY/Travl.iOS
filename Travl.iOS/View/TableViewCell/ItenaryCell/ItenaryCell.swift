//
//  ItenaryCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 27/08/2021.
//

import UIKit

final class ItenaryCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        headerLabel.text = nil
        descLabel.text = nil
        iconImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellContent(for itenary : Days) {
        headerLabel.text = itenary.locationName
        descLabel.text = itenary.description
        //iconImage.downloaded(from: itenary.image)
        iconImage.image = nil
    }

}
