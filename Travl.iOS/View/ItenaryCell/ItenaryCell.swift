//
//  ItenaryCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 27/08/2021.
//

import UIKit

class ItenaryCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
