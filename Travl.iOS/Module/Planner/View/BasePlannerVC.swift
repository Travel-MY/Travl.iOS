//
//  BasePlannerVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 24/09/2021.
//

import UIKit
#warning("""
 TODO :
1. Error Handling
2. Open Map App when get locations
""")
final class BasePlannerVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var basePlannerTableView: UITableView!
    //MARK: - Variables
    private var plannerData = [Planner]()
    private let presenter = BasePlannerPresenter()
    private let refreshControl = UIRefreshControl()
    private let analytics = AnalyticManager(engine: MixPanelAnalyticEngine())
    
    lazy var footer : BasePlannerImageFooter = {
        let footer = Bundle.main.loadNibNamed(R.nib.basePlannerImageFooter.name, owner: nil, options: nil)?.first as! BasePlannerImageFooter
        return footer
    }()
    lazy var header : BasePlannerTableHeader = {
        let header = Bundle.main.loadNibNamed(R.nib.basePlannerTableHeader.name, owner: nil, options: nil)?.first as! BasePlannerTableHeader
        return header
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        registerCustomNib()
        presenter.setViewDelegate(delegate: self)
        presenter.fetchImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchPlanner()
        analytics.log(.plannerScreenViewed)
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
        let title = (plannerData.isEmpty) ?  "" : "Your Planner"
        return title
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
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Get Inspired"
    }
}

//MARK: - Table Header Delegate
extension BasePlannerVC : BasePlannerTableHeaderDelegate {
    func didTapTripButton(view: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifier.goToCreatePlanner, sender: self)
        analytics.log(.createPlannerScreenView)
    }
}
//MARK: - Table Footer Delegate
extension BasePlannerVC : BasePlannerImageFooterDelegate {
    func presentActionForFooterTap(_ BasePlannerImageFooter: BasePlannerImageFooter) {
        // Open discover tab when footer get selected
        tabBarController?.selectedIndex = 0
        analytics.log(.viewGetInpiredSlider)
    }
}
//MARK: - Presenter Delegate
extension BasePlannerVC : BasePlannerPresenterDelegate {

    func presentToPlannerDetails(_ BasePlannerPresenter: BasePlannerPresenter, index: Int) {
        performSegue(withIdentifier: Constants.SegueIdentifier.goToPlannerDetails, sender: self)
        analytics.log(.viewCreatedPlanner(index: index))
    }
    
    func presentFetchPlanner(_ BasePlannerPresenter: BasePlannerPresenter, data: [Planner]) {
        DispatchQueue.main.async { [weak self] in
            self?.plannerData = data
            self?.basePlannerTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func presentFetchImages(_ BasePlannerPresenter: BasePlannerPresenter, data: [Images]) {
        DispatchQueue.main.async { [weak self] in
            self!.footer.setFooterImages(data)
        }
    }
}
//MARK: - Private methods
extension BasePlannerVC {
    
    private func renderView() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.primarySeaBlue]
        self.extendedLayoutIncludesOpaqueBars = true
        basePlannerTableView.delegate = self
        basePlannerTableView.dataSource = self
        basePlannerTableView.refreshControl = refreshControl
        basePlannerTableView.refreshControl?.addTarget(self, action: #selector(refreshContent(_:)), for: .valueChanged)
        basePlannerTableView.separatorStyle = .none
        basePlannerTableView.estimatedRowHeight = 110
    }
    
    private func registerCustomNib() {
        basePlannerTableView.register(PlannerItemsCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.plannerItemsCell.identifier)
        
        basePlannerTableView.tableHeaderView = header
        basePlannerTableView.tableFooterView = footer
        footer.setViewDelegate(delegate: self)
        header.setViewDelegate(delegate: self)
    }
    
    @objc private func refreshContent(_ sender : UIRefreshControl) {
        plannerData = []
        basePlannerTableView.reloadData()
   refreshControl.beginRefreshing()
        presenter.fetchPlanner()
    }
}

