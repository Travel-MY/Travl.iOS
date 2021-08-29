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
    @IBOutlet weak var cityDescription: UITextView!
    @IBOutlet weak var cityDescHC : NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make taxtview size dynamic based on it contents
        cityDescHC.constant = self.cityDescription.contentSize.height
        
        // Register custom cell for tv in itenary cell
        tableView.register(UINib(nibName: R.nib.itenaryCell.name, bundle: nil), forCellReuseIdentifier: R.nib.itenaryCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 80
        
        scrollView.showsVerticalScrollIndicator = false

    }
    
    func cellContent(location : Location,for itenary : Itenaries, at index : Int) {
        sloganLabel.text = location.slogan
        cityLabel.text = location.locationName
    }

}
