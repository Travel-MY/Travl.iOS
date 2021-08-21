//
//  ViewController.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 11/08/2021.
//

import UIKit

class DiscoverVC : UIViewController {
    
    var locationResult = [Location]()
    private var selectedAtRow : Int!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getLocations()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    func getLocations(location : String = "locations") {
        
        NetworkManager.shared.getLocations(for: location) {  [weak self] location in
            
            switch location {
            case .success(let locations):
                self?.updateDiscoverUI(with: locations)
                print(locations)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func updateDiscoverUI(with locations : [Location]) {
        
        DispatchQueue.main.async { [weak self] in
            self?.locationResult.append(contentsOf: locations)
            self?.collectionView.reloadData()
        }
       
    }
    
}

//MARK:- Delegate
extension DiscoverVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAtRow = indexPath.row
        self.performSegue(withIdentifier: R.segue.discoverVC.goToDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? DiscoverDetail else { return}
        guard let indexPath = collectionView.indexPathsForSelectedItems else {return}
        destinationVC.imageURL = locationResult[selectedAtRow].image
        // Remove tab bar when push to other vc
        destinationVC.hidesBottomBarWhenPushed = true
        //destinationVC.locationDetails = locationResult
       // destinationVC.backgroundImage = locationResult[selectedAtRow].image
    }
}

//MARK:- Data Source
extension DiscoverVC : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return locationResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let listOfLocations = locationResult[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cell, for: indexPath)!
        
        
        cell.locationImage.downloaded(from: listOfLocations.image)
        cell.locationImage.contentMode = .scaleToFill
        cell.locationLabel.text = listOfLocations.location_name
        
        return cell
    }
}



