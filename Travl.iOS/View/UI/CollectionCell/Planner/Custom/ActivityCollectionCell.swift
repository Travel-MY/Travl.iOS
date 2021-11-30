//
//  ActivityCollectionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/11/2021.
//

import UIKit

final class ActivityCollectionCell : UICollectionViewCell {
    
    //MARK: - Outles
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    //MARK: - Variables
    static let identifier = "ActivityCollectionCell"
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15
    }
    
    func setCell(data : Menu) {
        menuImage.image = UIImage(systemName: data.image)
        menuLabel.text = data.label
    }
    
}
