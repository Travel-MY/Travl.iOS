//
//  BasePlannerVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/09/2021.
//

import UIKit

class BasePlannerVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var basePlannerTableView: UITableView!
    
    //MARK:- Variables
    var plannerData : Any = []
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
}

//MARK:- TV DataSource
extension BasePlannerVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//MARK:- TV Delegate
extension BasePlannerVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

//MARK:- CreateATripHeader Delegate
extension BasePlannerVC : CreateATripHeaderDelegate {
    func didTapTripButton(view: Any) {
        print("Click")
        performSegue(withIdentifier: "goToCreatePlanner", sender: self)
    }
}

//MARK:- Private methods
extension BasePlannerVC {
    
    private func renderView() {
        
        basePlannerTableView.delegate = self
        basePlannerTableView.dataSource = self
        
        let header = Bundle.main.loadNibNamed(R.nib.createATripHeader.identifier, owner: nil, options: nil)?.first as! CreateATripHeader
        basePlannerTableView.tableHeaderView = header
        
        header.setViewDelegate(delegate: self)
        
        let footer = Bundle.main.loadNibNamed(R.nib.imageSliderFooter.identifier, owner: nil, options: nil)?.first as! ImageSliderFooter
        
        basePlannerTableView.tableFooterView = footer

    }
}
