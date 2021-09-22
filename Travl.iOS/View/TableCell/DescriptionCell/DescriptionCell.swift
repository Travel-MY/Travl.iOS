//
//  DescriptionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 08/09/2021.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var itenaryDescription : UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.descriptionCell.name, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with data : String) {
        itenaryDescription.text = data
    }
    
}
