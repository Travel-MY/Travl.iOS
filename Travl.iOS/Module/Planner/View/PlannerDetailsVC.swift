//
//  PlannerActivitiesVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 29/10/2021.
//

import UIKit
import CoreData

final class PlannerDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var plannerTableView : UITableView!
    @IBOutlet weak var activityMenuContainerView: UIView!
    
    //MARK: - Variables
    var selectedPlanner : Planner!

    var activityData = [Activity]()
    var selectedRow : Int!
    var selectedPlannerIndexPath : Int!
    var context = Constants.accessManageObjectContext
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadActivities()
        print("Key stored in User Defaults is : \( UserDefaults.standard.string(forKey: "parentPlanner") )")
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
            return 135
        default :
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, didSwipe in
            if let activityToRemove = self?.activityData[indexPath.row] {
                self?.removeActivity(activityToRemove)
                self?.loadActivities()
            }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
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
        if let alDetailsVC = segue.destination  as? ALDetailsVC {
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
#warning("Move this method to presenter")
//MARK: - Core Data Manipulation Methods
extension PlannerDetailsVC {
    private func loadActivities(with request : NSFetchRequest<Activity> = Activity.fetchRequest(), predicate : NSPredicate? = nil ) {
        let predicate = NSPredicate(format: "parentPlanner.destination MATCHES %@", selectedPlanner.destination)
        request.predicate = predicate
        
        do {
            activityData = try context.fetch(request)
        } catch {
            print("Error Fetch Data from Core Data : \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.plannerTableView.reloadData()
        }
    }
    
    private func removeActivity(_ activity : NSManagedObject) {
        context.delete(activity)
        do {
            try context.save()
        } catch {
            print("Error delete context : \(error.localizedDescription)")
        }
    }
}
//MARK: - Private methods
extension PlannerDetailsVC {
    @objc func presentToActivityMenu() {
        performSegue(withIdentifier: "goToActivityMenu", sender: self)
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


