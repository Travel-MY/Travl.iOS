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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        contentView.frame = contentView.frame.inset(by: padding)
        contentView.layer.cornerRadius = 15
    }
    
    
    
}
