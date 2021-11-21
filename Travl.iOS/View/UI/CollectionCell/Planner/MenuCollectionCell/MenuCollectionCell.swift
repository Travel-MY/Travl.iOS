//
//  MenuCollectionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 14/11/2021.
//

import UIKit

final class MenuCollectionCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        renderView()
    }
    
    override func prepareForReuse() {
        iconImage.image = nil
        itemLabel.text = nil
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.menuCollectionCell.name, bundle: nil)
    }
    
    func setCell(icon : String, label : String) {
        iconImage.image = UIImage(systemName: icon)
        itemLabel.text = label
    }
}

//MARK: - Private Methods
extension MenuCollectionCell {
    
    private func renderView() {
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        contentView.frame = contentView.frame.inset(by: padding)
        contentView.layer.cornerRadius = 15
    }
}
