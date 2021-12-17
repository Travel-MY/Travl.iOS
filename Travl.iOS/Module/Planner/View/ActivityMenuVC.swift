//
//  ActivityMenuVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/11/2021.
//

import UIKit

final class ActivityMenuVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var activityCollectionView: UICollectionView!
    //MARK: - Variables
    var data : Planner?
    
    private let presenter = ActivityMenuPresenter()
    private let analytic = AnalyticManager(engine: MixPanelAnalyticEngine())
    private var selectedRow = 0
    private var menuItem = [Menu]()
    private var newActivity : Activity? {
        didSet {
            observerActions()
        }
    }
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        presenter.setViewDelegate(delegate: self)
        analytic.log(.selectTypeOfActivitiesScreenView)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tourMenuVC = segue.destination as? TourMenuVC {
            if let destination = UserDefaults.standard.string(forKey: Constants.UserDefautlsKey.primaryKeyForPlanner) {
                tourMenuVC.destinationName = destination
            }
            let selectedActivity = menuItem[selectedRow]
            tourMenuVC.navBarLabel = selectedActivity.label
        }
    }
    
    @objc func observerActions() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - CV Datasource
extension ActivityMenuVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listOfMenu = menuItem[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.activityCollectionCell.identifier, for: indexPath) as! ActivityCollectionCell
        cell.setCell(data: listOfMenu)
        return cell
    }
}
//MARK: - CV Delegate
extension ActivityMenuVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("selected activity at row : \(indexPath.row)")
        presenter.didTapActivityMenu(atIndex: indexPath.row)
    }
}
//MARK: - Presenter Delegate
extension ActivityMenuVC : ActivityMenuPresenterDelegate {
    func presentToTourMenu(_ ActivityMenuPresenter: ActivityMenuPresenter, index: Int) {
        selectedRow = index
        if index <= 1 {
            performSegue(withIdentifier: Constants.SegueIdentifier.goToTourMenu, sender: self)
        }
    }
}

//MARK: - Private methods
extension ActivityMenuVC {
    private func renderView() {
        activityCollectionView.delegate = self
        activityCollectionView.dataSource = self
        
        menuItem =  [
            Menu(image: "map.circle.fill", label: "Location"),
            Menu(image: "fork.knife.circle.fill", label: "Restaurant"),
            //            Menu(image: "bed.double.circle.fill", label: "Lodging"),
            //            Menu(image: "airplane.circle.fill", label: "Flight")
        ]
        NotificationCenter.default.addObserver(self, selector: #selector(observerActions), name: Notification.Name(rawValue: "Dismiss"), object: nil)
    }
}
