//
//  PlannerDateCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 12/11/2021.
//

import UIKit

final class PlannerDateCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var numberDaysLabel: UILabel!
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
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.plannerDateCell.name, bundle: nil)
    }
    
    //MARK: - TODO : Add number of days property in Planner model
    func setCell(data : Planner) {
        self.startDateLabel.text = data.startDate
        self.endDateLabel.text = data.endDate
    }
    
    override func prepareForReuse() {
        numberDaysLabel.text = nil
        startDateLabel.text = nil
        endDateLabel.text = nil
    }

    private func renderView() {
        let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        contentView.frame = contentView.frame.inset(by: padding)
        contentView.layer.cornerRadius = 15
        self.selectionStyle = .none
    }
    
}
