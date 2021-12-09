//
//  ActivityInfoCellTableViewCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 02/12/2021.
//

import UIKit

final class ActivityInfoCellTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var phoneNumberLabel : UILabel!
    @IBOutlet weak var websiteLabel : UILabel!
    @IBOutlet var iconImage: [UIImageView]!
    //MARK: - Variables
    static let identifier = "ActivityInfoCellTableViewCell"
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        renderView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.activityInfoCellTableViewCell.name, bundle: nil)
    }
    
    func configureCell(data : Activity) {
        addressLabel.text = data.address
        phoneNumberLabel.text = data.phoneNumber
        websiteLabel.text = data.website
    }
}

//MARK: - Private Methods
extension ActivityInfoCellTableViewCell {
    private func renderView() {
        contentView.backgroundColor = .secondaryLightTurqoise
        contentView.addCellPadding(top: 10)
        contentView.addRoundedCorners()
        addressLabel.textColor = .white
        websiteLabel.textColor = .white
        phoneNumberLabel.textColor = .white
        selectionStyle = .none
        iconImage.forEach { icon in
            icon.tintColor = .white
        }
    }
}
