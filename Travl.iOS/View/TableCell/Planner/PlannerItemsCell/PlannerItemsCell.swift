//
//  PlannerItemsCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/10/2021.
//

import UIKit

final class PlannerItemsCell: UITableViewCell {

    static func nib() -> UINib {
        return UINib(nibName: R.nib.plannerItemsCell.name, bundle: nil)
    }
    
    //MARK:- Outles
    @IBOutlet weak private var destinationLabel: UILabel!
    @IBOutlet weak private var startLabel: UILabel!
    @IBOutlet weak private var endLabel: UILabel!
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        destinationLabel.text = nil
        startLabel.text = nil
        endLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20))
        contentView.layer.cornerRadius = 10
        self.selectionStyle = .none
    }
    
    func configureCell(data : Planner) {
        destinationLabel.text = data.destination
        startLabel.text = data.startDate
        endLabel.text = data.endDate
    }
    
}
