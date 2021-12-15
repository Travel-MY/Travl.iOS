//
//  ActivityListCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 30/11/2021.
//

import UIKit

final class ActivityListCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    
    //MARK: - Variables
    static let identifier = "ActivityListCell"
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        renderView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.activityListCell.name, bundle: nil)
    }
    
    func configureCell(data : Activity) {
        activityName.text = data.name
        address.text = data.category
        date.text = data.startDate
        if data.category == "Location" {
            activityImageView.image = UIImage(systemName: "map.circle.fill")
        } else {
            activityImageView.image = UIImage(systemName: "fork.knife.circle.fill")
        }
    }
}


//MARK: - Private Methods
extension ActivityListCell {
    private func renderView() {
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
        contentView.layer.borderColor = UIColor.secondaryLightTurqoise.cgColor
        contentView.layer.borderWidth = 1
        activityImageView.tintColor = .secondaryLightTurqoise
        activityName.textColor = .secondaryLightTurqoise
        date.textColor = .subtitleGrayLabel
        selectionStyle = .none
    }
}
