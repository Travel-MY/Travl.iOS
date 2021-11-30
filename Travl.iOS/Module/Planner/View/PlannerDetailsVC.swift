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
    @IBOutlet weak var activityMenuContainerView: UIView!
    
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
        return 2
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
        case 1 :
            let cell = plannerTableView.dequeueReusableCell(withIdentifier: ActivityListCell.identifier, for: indexPath) as! ActivityListCell
            #warning("Insert content for Activity List here")
        //    cell.activityName.text = "Hello"
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 200
        case 1 :
            return 125
        default :
            return 100
        }
        
    }
}

//MARK: - TV Delegate
extension PlannerDetailsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    @objc func presentToActivityMenu() {
        performSegue(withIdentifier: "goToActivityMenu", sender: self)
        print("HELO")
    }
    private func renderView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentToActivityMenu))
        activityMenuContainerView.addGestureRecognizer(tap)
        
        plannerTableView.separatorStyle = .none
        plannerTableView.dataSource = self
        plannerTableView.delegate = self
        
        plannerTableView.register(PlannerDateCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerDateCell.identifier)
        plannerTableView.register(ActivityListCell.nib(), forCellReuseIdentifier: ActivityListCell.identifier)
    }
}


