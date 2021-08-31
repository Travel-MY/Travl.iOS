//
//  ItenaryFloatingPanelVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 31/08/2021.
//

import UIKit

class ItenaryFP: UIViewController{
    
    //MARK:- Outlets
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locDesc: UITextView!
    @IBOutlet weak var itenaryTableView: UITableView!
    
    @IBOutlet weak var locDescHC: NSLayoutConstraint!
    
    var itenaries = [[Days]]()
    var location : Location!
    var locationName : String!
    
    override func viewDidLoad() {
        renderView()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        itenaries = []
    }
    
    func renderView() {
        itenaryTableView.register(UINib(nibName: R.nib.itenaryCell.name, bundle: nil), forCellReuseIdentifier: R.nib.itenaryCell.identifier)
        
        itenaryTableView.dataSource = self
        itenaryTableView.delegate = self
        
        locDescHC.constant = locDesc.contentSize.height
        
        locationLabel.text = location.locationName
        locDesc.text = location.description
        sloganLabel.text = location.slogan
        
    }
}

//MARK:- Data source
extension ItenaryFP : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return itenaries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itenaries[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItenaryCell = itenaryTableView.dequeueReusableCell(withIdentifier: R.nib.itenaryCell.identifier, for: indexPath) as! ItenaryCell
        
        let listOfItenaries = itenaries[indexPath.section][indexPath.row]
        cell.cellContent(for: listOfItenaries)
        
        return cell
    }
}

//MARK:- Delegate
extension ItenaryFP : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Remove highlight when cell selected
        itenaryTableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK:- ItenaryVC Delegate
extension ItenaryFP : ItenaryVCDelegate {
    
    func didSendItenaryData(_ itenaryVC: ItenaryVC, with itenary: [[Days]]) {
        DispatchQueue.main.async {
            //print(itenary)
            self.itenaries.append(contentsOf: itenary)
            self.itenaryTableView.reloadData()
            print("itenary \(self.itenaries.count)")
        }
    }
    
    
}
