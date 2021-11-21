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
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = plannerTableView.dequeueReusableCell(withIdentifier: R.nib.plannerDateCell.identifier, for: indexPath) as! PlannerDateCell
            cell.setCell(data: selectedPlanner)
            return cell
            
        case 1 :
            let cell = plannerTableView.dequeueReusableCell(withIdentifier: R.nib.plannerActivityContentCell.identifier, for: indexPath) as! PlannerActivityContentCell
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension PlannerDetailsVC {
    private func renderView() {
        plannerTableView.separatorStyle = .none
        plannerTableView.dataSource = self
        plannerTableView.delegate = self

        plannerTableView.register(PlannerDateCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerDateCell.identifier)
        plannerTableView.register(PlannerActivityContentCell.nib(), forCellReuseIdentifier: R.nib.plannerActivityContentCell.identifier)
    
    }
}

