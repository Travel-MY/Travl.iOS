//
//  TourMenuVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/11/2021.
//

import UIKit

final class TourMenuVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var selectedActivityLabel: UILabel!
    
    //MARK: - Variables
    var navBarLabel : String?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedActivityLabel.text = navBarLabel
    }
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTap(_ sender: UIButton) {
    }
}


