//
//  ViewController.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 11/08/2021.
//

import UIKit



class DiscoverVC : UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var locationResult = [Location]()
    private var selectedAtRow : Int!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        getLocations()
        
  
    }
    
    private func renderView() {
        
        collectionView.register(UINib(nibName: R.nib.discoverCell.name, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.discoverCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    private func getLocations(location : String = "locations") {
        
        NetworkManager.shared.getLocations(for: location) {  [weak self] location in
            
            switch location {
            
            case .success(let locations):
                self?.updateDiscoverUI(with: locations)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func updateDiscoverUI(with locations : [Location]) {
        
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
        
        guard let destinationVC = segue.destination as? ItenaryVC else { return}
        
        destinationVC.locationDetails = locationResult[selectedAtRow]
        destinationVC.imageURL = locationResult[selectedAtRow].image
        destinationVC.getItenaries(at: locationResult[selectedAtRow].itenaryName)
        
        // Remove tab bar when push to other vc
        destinationVC.hidesBottomBarWhenPushed = true
        
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.discoverCell.identifier, for: indexPath) as! DiscoverCell
        let listOfLocations = locationResult[indexPath.row]
        
        cell.cellContent(for: listOfLocations)
        
        return cell
    }
}

//MARK:- FlowLayoutDelegate
extension DiscoverVC : UICollectionViewDelegateFlowLayout {
    
    // Ask delegate for size of specified cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        let heigt = view.frame.size.height
        return CGSize(width: width * 0.4, height: heigt * 0.25)
    }
    // Ask delegate for margin to apply to content in specific section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
}


