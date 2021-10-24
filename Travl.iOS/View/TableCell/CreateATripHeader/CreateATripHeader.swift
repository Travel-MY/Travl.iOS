//
//  CreateATripHeader.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 01/10/2021.
//

import UIKit

protocol CreateATripHeaderDelegate : AnyObject {
    func didTapTripButton(view : Any)
}

final class CreateATripHeader: UITableViewHeaderFooterView {

    weak var delegate : CreateATripHeaderDelegate?
    
    func setViewDelegate(delegate : CreateATripHeaderDelegate) {
        self.delegate = delegate
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20))
        contentView.layer.cornerRadius = 25
    }
    
    @IBAction func createTripPressed(_ sender: UIButton) {
        delegate?.didTapTripButton(view: self)
    }
}
