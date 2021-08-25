//
//  CardVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/08/2021.
//

import UIKit

class CardView: UIViewController {

    @IBOutlet weak var handlerArea: UIView!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func cellContent(location : Location,for itenary : Itenaries, at index : Int) {
        sloganLabel.text = location.slogan
        cityLabel.text = location.locationName
    }

}
