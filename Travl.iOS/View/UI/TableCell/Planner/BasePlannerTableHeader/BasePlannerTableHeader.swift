//
//  CreateATripHeader.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 01/10/2021.
//

import UIKit

protocol BasePlannerTableHeaderDelegate : AnyObject {
    func didTapTripButton(view : Any)
}

final class BasePlannerTableHeader: UITableViewHeaderFooterView {

    weak var delegate : BasePlannerTableHeaderDelegate?
    
    func setViewDelegate(delegate : BasePlannerTableHeaderDelegate) {
        self.delegate = delegate
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
    }
    
    @IBAction func createTripPressed(_ sender: UIButton) {
        delegate?.didTapTripButton(view: self)
    }
}
