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
    var activityData = [Activity]()
    var selectedRow : Int!
    
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
        switch section {
        case 1 :
            return activityData.count
        default:
            return 1
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = plannerTableView.dequeueReusableCell(withIdentifier: R.nib.plannerDateCell.identifier, for: indexPath) as! PlannerDateCell
            cell.setCell(data: selectedPlanner)
            return cell
        case 1 :
            let cell = plannerTableView.dequeueReusableCell(withIdentifier: ActivityListCell.identifier, for: indexPath) as! ActivityListCell
            let activity = activityData[indexPath.row]
            cell.configureCell(data: activity)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return 170
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
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            performSegue(withIdentifier: "goToALDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let activityMenuVC = segue.destination as? ActivityMenuVC {
            activityMenuVC.data = selectedPlanner
            activityMenuVC.delegate = self
        } else if let alDetailsVC = segue.destination  as? ALDetailsViewController {
            alDetailsVC.selectedActivity = activityData[selectedRow]
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Plan"
        } else if section == 1 {
            return "Your Activities"
        }
        return ""
    }
}

//MARK: - ActivityMenuVCDelegate
extension PlannerDetailsVC : ActivityMenuVCDelegate {
    func presentNewActivity(_ activityMenuVC: ActivityMenuVC, data: Activity) {
        activityData.append(data)
        plannerTableView.reloadData()
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
        
        let stub = Activity(category: "Restaurant", name: "Sepiring", address: "241, Suria KLCC, Kuala Lumpur City Centre, 50088 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur", startDate: "Nov 20, 2021", endDate: "", phoneNumber: "+60323822828", website: "https://www.suriaklcc.com.my/", notes: "")
        activityData.append(stub)
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentToActivityMenu))
        activityMenuContainerView.addGestureRecognizer(tap)
        
        plannerTableView.separatorStyle = .none
        plannerTableView.dataSource = self
        plannerTableView.delegate = self
        
        plannerTableView.register(PlannerDateCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerDateCell.identifier)
        plannerTableView.register(ActivityListCell.nib(), forCellReuseIdentifier: ActivityListCell.identifier)
    }
}


