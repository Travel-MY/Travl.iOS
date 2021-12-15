//
//  BasePlannerVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/09/2021.
//

import UIKit

final class BasePlannerVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var basePlannerTableView: UITableView!
    //MARK: - Variables
    private var plannerData = [Planner]()
    let presenter = BasePlannerPresenter()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        presenter.setViewDelegate(delegate: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchPlanner()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.basePlannerVC.goToPlannerDetails.identifier {
            let plannerActivities = segue.destination as! PlannerDetailsVC
            // Get selected index from tableview with accessing its outlet property
            guard let atIndex = basePlannerTableView.indexPathForSelectedRow?.row else {return}
            plannerActivities.selectedPlanner = plannerData[atIndex]
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
        presenter.didTapPlannerRow(atIndex: indexPath.row)
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
                self?.presenter.removePlanner(plannerToRemove)
                self?.presenter.fetchPlanner()
            }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }
}

//MARK: - CreateATripHeader Delegate
extension BasePlannerVC : BasePlannerTableHeaderDelegate {
    func didTapTripButton(view: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifier.goToCreatePlanner, sender: self)
    }
}
//MARK: - Presenter Delegate
extension BasePlannerVC : BasePlannerPresenterDelegate {
    func presentToPlannerDetails(_ BasePlannerPresenter: BasePlannerPresenter, index: Int) {
        performSegue(withIdentifier: Constants.SegueIdentifier.goToPlannerDetails, sender: self)
    }
    
    func presentFetchPlanner(_ BasePlannerPresenter: BasePlannerPresenter, data: [Planner]) {
        DispatchQueue.main.async { [weak self] in
            self?.plannerData = data
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

