//
//  PlannerActivitiesVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 29/10/2021.
//

import UIKit

final class PlannerDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var plannerTableView : UITableView!
    
    //MARK: - Variables
    var selectedPlanner : Planner!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
}

//MARK: - TV Datasource
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
            cell.setViewDelegate(delegate: self)
            return cell
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 200
        case 1 :
            return 100
        default:
            return 100
        }
    }
}

//MARK: - TV Delegate
extension PlannerDetailsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - PlannerActivityContentCellDelegate
extension PlannerDetailsVC : PlannerActivityContentCellDelegate {
    func didSelectAtContent(_ plannerActivityContentCell: PlannerActivityContentCell, indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "goToActivityMenu", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let activityMenuVC = segue.destination as? ActivityMenuVC {
            activityMenuVC.data = selectedPlanner
            activityMenuVC.delegate = self
        }
    }
    
    
}
//MARK: - ActivityMenuVCDelegate
extension PlannerDetailsVC : ActivityMenuVCDelegate {
    #warning("Handle data activity that created by TourMenuVC")
    func presentNewActivity(_ activityMenuVC: ActivityMenuVC, data: Activity) {
        print("RECEIVE DATA FROM ActivityMenuVCDelegate at PlannerDetailsVC")
    }
}
//MARK: - Private methods
extension PlannerDetailsVC {
    private func renderView() {
        plannerTableView.separatorStyle = .none
        plannerTableView.dataSource = self
        plannerTableView.delegate = self

        plannerTableView.register(PlannerDateCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerDateCell.identifier)
        plannerTableView.register(PlannerActivityContentCell.nib(), forCellReuseIdentifier: R.nib.plannerActivityContentCell.identifier)
    
    }
}

