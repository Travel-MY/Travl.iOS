//
//  PlannerTableCollectionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 14/11/2021.
//

import UIKit

final class PlannerActivityContentCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var activityContentCollectionView: UICollectionView!
    
    //MARK: - Variable
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        renderView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.plannerActivityContentCell.name, bundle: nil)
    }
    
}

//MARK: - CV Datasource
extension PlannerActivityContentCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
            
        default :
            return UICollectionViewCell()
        }
    }
}

//MARK: - CV Delegate
extension PlannerActivityContentCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected at row : \(indexPath.row)")
    }
}

//MARK: - Private methods
extension PlannerActivityContentCell {
    
    private func renderView() {
        activityContentCollectionView.delegate = self
        activityContentCollectionView.dataSource = self
    }
}
