//
//  ViewController.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 11/08/2021.
//

import UIKit

final class BaseDiscoverVC : UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    private var locationResult = [Location]()
    private var selectedAtRow : Int!
    private let presenter = BaseDiscoverPresenter()
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        // Open planner tab bar when it view appear
        self.tabBarController?.selectedIndex = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getLocations()
        renderView()
    }
}

//MARK: - Delegate
extension BaseDiscoverVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapLocation(atIndex : indexPath.row)
    }
    
    //MARK:- Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? ItenaryVC else { return}
        // Passing location object to ItenaryVC
        destinationVC.locationName = locationResult[selectedAtRow]
        destinationVC.imageURL = locationResult[selectedAtRow].image
        
        // Remove tab bar when push to other vc
        destinationVC.hidesBottomBarWhenPushed = true
    }
}

//MARK:- Data Source
extension BaseDiscoverVC : UICollectionViewDataSource {
    
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
extension BaseDiscoverVC : UICollectionViewDelegateFlowLayout {
    
    // Ask delegate for size of specified cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        return CGSize(width: width * 0.4, height: height * 0.3)
    }
    // Ask delegate for margin to apply to content in specific section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }
}

//MARK:- DiscoverPresenterDelegate
extension BaseDiscoverVC : BaseDiscoverPresenterDelegate {
    
    func presentToNextScreen(atCellNumber: Int) {
        selectedAtRow = atCellNumber
        self.performSegue(withIdentifier: R.segue.baseDiscoverVC.goToDetails, sender: self)
    }

    func presentLocation(data: [Location]) {
        locationResult = data
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - Private methods
extension BaseDiscoverVC {
    
    private func renderView() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.primarySeaBlue]
        presenter.setViewDelegate(delegate: self)
        //presenter.getLocations()
        collectionView.register(UINib(nibName: R.nib.discoverCell.name, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.discoverCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
