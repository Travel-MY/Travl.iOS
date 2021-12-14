//
//  BasePlannerVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/09/2021.
//

import UIKit
import CoreData

final class BasePlannerVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var basePlannerTableView: UITableView!
    
    //MARK: - Variables
    private var plannerData = [Planner]()
    private var rowIndexPath : Int!
    private var context = Constants.accessManageObjectContext

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPlanner()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.basePlannerVC.goToPlannerDetails.identifier {
            let plannerActivities = segue.destination as! PlannerDetailsVC
            plannerActivities.selectedPlanner = plannerData[rowIndexPath]
        }
    }
}

//MARK: - TV DataSource
extension BasePlannerVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plannerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listOfPlanner = plannerData[indexPath.row]
        let cell = basePlannerTableView.dequeueReusableCell(withIdentifier: R.nib.plannerItemsCell.identifier, for: indexPath) as! PlannerItemsCell
        cell.configureCell(data: listOfPlanner)
        return cell
    }
}

//MARK: - TV Delegate
extension BasePlannerVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndexPath = indexPath.row
        performSegue(withIdentifier: "goToPlannerDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        basePlannerTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Planner"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let action =  UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, didSwipeRow in
            if let plannerToRemove = self?.plannerData[indexPath.row] {
                self?.removePlanner(plannerToRemove)
                self?.fetchPlanner()
            }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }
}

//MARK: - CreateATripHeader Delegate
extension BasePlannerVC : BasePlannerTableHeaderDelegate {
    func didTapTripButton(view: Any) {
        performSegue(withIdentifier: "goToCreatePlanner", sender: self)
    }
}
#warning("Separate this logic in the presenter")
//MARK: - Core Data Manipulation Methods
extension BasePlannerVC {
    private func removePlanner(_ planner : NSManagedObject) {
        context.delete(planner)
        do {
            try context.save()
        } catch {
            print("Error saving context : \(error.localizedDescription)")
        }
    }
    
    private func fetchPlanner() {
        let request = Planner.fetchRequest()
        do {
            let collectionOfPlanners = try Constants.accessManageObjectContext.fetch(request)
            plannerData = collectionOfPlanners
        } catch {
            print("Error fetch data from Core Data : \(error.localizedDescription)")
        }
        DispatchQueue.main.async { [weak self] in
            self?.basePlannerTableView.reloadData()
        }
    }
    
}

//MARK: - Private methods
extension BasePlannerVC {
    
    private func renderView() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.primarySeaBlue]
        
        basePlannerTableView.delegate = self
        basePlannerTableView.dataSource = self
        basePlannerTableView.separatorStyle = .none
        basePlannerTableView.estimatedRowHeight = 110
        basePlannerTableView.rowHeight = UITableView.automaticDimension
        
        registerCustomNib()
    }
    
    private func registerCustomNib() {
        
        basePlannerTableView.register(PlannerItemsCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerItemsCell.identifier)
        let header = Bundle.main.loadNibNamed(R.nib.basePlannerTableHeader.name, owner: nil, options: nil)?.first as! BasePlannerTableHeader
        #warning("Update image based on image API provided")
        let footer = Bundle.main.loadNibNamed(R.nib.basePlannerImageFooter.name, owner: nil, options: nil)?.first as! BasePlannerImageFooter
        
        basePlannerTableView.tableHeaderView = header
        basePlannerTableView.tableFooterView = footer
        header.setViewDelegate(delegate: self)
    }
}

