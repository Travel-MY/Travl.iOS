//
//  CollectionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 08/09/2021.
//

import UIKit

final class ItenaryInfoCollectionCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var collectionView : UICollectionView!
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.itenaryInfoCollectionCell.name, bundle: nil)
    }
    
    var selectedDays : Days?
    private var cellLabel = ["Phone Number", "Website"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        renderView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
    }
    
    func configureCell(with data : Days) {
        self.selectedDays = data
        collectionView.reloadData()
    }
}

//MARK:- CV DataSource
extension ItenaryInfoCollectionCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Selected Days? \(selectedDays!) from CollectionCell")
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.infoCell.identifier, for: indexPath) as! InfoCell
        switch indexPath.row {
        case 0:
            if let phoneNumber = selectedDays?.phoneNumber {
                let result = (phoneNumber == "") ? "N/A" : phoneNumber
                cell.configureCell(label: "Phone Number", data: result)
            }
            return cell
        case 1:
            if let website = selectedDays?.website {
                let result = (website == "") ? "N/A" : website
                cell.configureCell(label: "Website", data: result)
            }
            return cell
        default:
            return cell
        }
    }
}
//MARK: - CV Delegate
extension ItenaryInfoCollectionCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
}

extension ItenaryInfoCollectionCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}

extension ItenaryInfoCollectionCell {
    private func renderView() {
        //MARK: - Register CustomCV cells
        collectionView.register(InfoCell.nib(), forCellWithReuseIdentifier: R.reuseIdentifier.infoCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}
