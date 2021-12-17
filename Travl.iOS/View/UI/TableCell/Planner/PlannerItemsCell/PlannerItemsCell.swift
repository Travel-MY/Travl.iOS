//
//  PlannerItemsCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/10/2021.
//

import UIKit

final class PlannerItemsCell: UITableViewCell {
    
    //MARK: - Outles
    @IBOutlet weak private var destinationLabel: UILabel!
    @IBOutlet weak private var startLabel: UILabel!
    @IBOutlet weak private var endLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        destinationLabel.text = nil
        startLabel.text = nil
        endLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        renderView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.plannerItemsCell.name, bundle: nil)
    }
    
    func configureCell(data : Planner) {
        destinationLabel.text = data.destination
        startLabel.text = DateFormatter().convertDateToString(data.startDate)
        endLabel.text = DateFormatter().convertDateToString(data.endDate)
    }
}

//MARK: - Private Methods
extension PlannerItemsCell {
    private func renderView() {
        self.selectionStyle = .none
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
        contentView.backgroundColor = .secondaryLightTurqoise
        destinationLabel.textColor = .white
        startLabel.textColor = .white
        endLabel.textColor = .white
        iconImage.tintColor = .white
    }
}
