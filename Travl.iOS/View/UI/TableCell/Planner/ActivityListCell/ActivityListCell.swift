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
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.activityListCell.name, bundle: nil)
    }
    
    func configureCell(data : Activity) {
        activityName.text = data.name
        address.text = data.category
        date.text = data.startDate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
        selectionStyle = .none
    }
    
    
    
}
