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
    var menuItem = [Menu]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    //MARK: - Actions
    @IBAction func cancelButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
    }
}

//MARK: - Private methods
extension ActivityMenuVC {
    private func renderView() {
        activityCollectionView.delegate = self
        activityCollectionView.dataSource = self
        
        menuItem =  [
            Menu(image: "map.circle.fill", label: "Location"),
            Menu(image: "bed.double.circle.fill", label: "Lodging"),
            Menu(image: "fork.knife.circle.fill", label: "Restaurant"),
            Menu(image: "airplane.circle.fill", label: "Flight")
        ]
    }
    
}
