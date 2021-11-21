//
//  InfoCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 09/09/2021.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    //MARK:- Outlet
    @IBOutlet weak var infoLabel : UILabel!
    @IBOutlet weak var infoContext : UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.infoCell.name, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(label : String, context : String) {
        infoLabel.text = label
        infoContext.text = context
    }

}
