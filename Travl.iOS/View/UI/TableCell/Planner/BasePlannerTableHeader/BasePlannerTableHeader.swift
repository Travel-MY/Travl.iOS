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
    
    //MARK: - Outlets
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createTripBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    //MARK: - Variables
    weak var delegate : BasePlannerTableHeaderDelegate?
    
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        renderView()
    }
    
    func setViewDelegate(delegate : BasePlannerTableHeaderDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Actions
    @IBAction func createTripPressed(_ sender: UIButton) {
        delegate?.didTapTripButton(view: self)
    }
}
//MARK: - Private Methods
extension BasePlannerTableHeader {
    private func renderView() {
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
        contentView.backgroundColor = .secondaryLightTurqoise
        greetingsLabel.textColor = .white
        descriptionLabel.textColor = .white
        createTripBtn.backgroundColor = .white
        createTripBtn.tintColor = .headingBlackLabel
        createTripBtn.addRoundedCorners()
        image.tintColor = .white
    }
}
