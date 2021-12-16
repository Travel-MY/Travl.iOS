//
//  PlannerDateCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 12/11/2021.
//

import UIKit

final class PlannerDateCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        renderView()
    }
    
    override func prepareForReuse() {
        destinationLabel.text = nil
        startDateLabel.text = nil
        endDateLabel.text = nil
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.plannerDateCell.name, bundle: nil)
    }
    
    func setCell(data : Planner) {
        self.destinationLabel.text = data.destination
        self.startDateLabel.text = DateFormatter().convertDateToString(data.startDate)
        self.endDateLabel.text = DateFormatter().convertDateToString(data.endDate)
    }

    private func renderView() {
        contentView.addCellPadding(top: 0)
        contentView.addRoundedCorners()
        destinationLabel.textColor = .primarySeaBlue
        startDateLabel.textColor = .headingBlackLabel
        endDateLabel.textColor = .headingBlackLabel
        iconImageView.tintColor = .subtitleGrayLabel
        self.selectionStyle = .none
    }
    
}
