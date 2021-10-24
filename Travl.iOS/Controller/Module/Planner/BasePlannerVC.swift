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
    var plannerData = [Planner]()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.basePlannerVC.goToCreatePlanner.identifier {
            let createPlannerVC = segue.destination as! CreatePlannerVC
            createPlannerVC.delegate = self
        }
    }
}

//MARK:- TV DataSource
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

//MARK:- TV Delegate
extension BasePlannerVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        basePlannerTableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- CreateATripHeader Delegate
extension BasePlannerVC : CreateATripHeaderDelegate {
    func didTapTripButton(view: Any) {
        performSegue(withIdentifier: "goToCreatePlanner", sender: self)
    }
}

//MARK:- Private methods
extension BasePlannerVC {
    
    private func renderView() {
        basePlannerTableView.delegate = self
        basePlannerTableView.dataSource = self
        
        basePlannerTableView.estimatedRowHeight = 110
        basePlannerTableView.rowHeight = UITableView.automaticDimension
        
        registerCustomNib()
    }
    
    private func registerCustomNib() {
        basePlannerTableView.register(PlannerItemsCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerItemsCell.identifier)
        
        let header = Bundle.main.loadNibNamed(R.nib.createATripHeader.identifier, owner: nil, options: nil)?.first as! CreateATripHeader
        basePlannerTableView.tableHeaderView = header
        
        header.setViewDelegate(delegate: self)
        
        let footer = Bundle.main.loadNibNamed(R.nib.imageSliderFooter.identifier, owner: nil, options: nil)?.first as! ImageSliderFooter
        
        basePlannerTableView.tableFooterView = footer
        
     
    }
}

//MARK:- CreatePlannerDelegate
extension BasePlannerVC : CreatePlannerDelegate {
    
    func didCreatePlanner(_ CreatePlanner: CreatePlannerVC, data: Planner) {
    
        plannerData.append(data)
        basePlannerTableView.reloadData()
        print(plannerData.count)
    }
}
