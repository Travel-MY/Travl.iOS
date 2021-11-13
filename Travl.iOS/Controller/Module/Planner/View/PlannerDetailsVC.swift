//
//  PlannerActivitiesVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 29/10/2021.
//

import UIKit

final class PlannerDetailsVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var plannerTableView : UITableView!
    
    var selectedPlanner : Planner!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
}
extension PlannerDetailsVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = plannerTableView.dequeueReusableCell(withIdentifier: R.nib.plannerDateCell.identifier, for: indexPath) as! PlannerDateCell
            cell.setCell(data: selectedPlanner)
            return cell
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 190
        default:
            return 100
        }
    }
}
extension PlannerDetailsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension PlannerDetailsVC {
    private func renderView() {
        plannerTableView.dataSource = self
        plannerTableView.delegate = self

        plannerTableView.register(PlannerDateCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerDateCell.identifier)
    
  

        
    }
}

