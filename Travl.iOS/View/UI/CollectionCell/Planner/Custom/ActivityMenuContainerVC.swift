//
//  ActivityMenuContainerVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 30/11/2021.
//

import UIKit

final class ActivityMenuContainerVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.textColor = .white
        iconImage.tintColor = .white
        view.backgroundColor = .secondaryLightTurqoise
        self.view.addRoundedCorners()
    }
}
