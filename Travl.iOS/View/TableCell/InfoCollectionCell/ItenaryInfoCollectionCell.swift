//
//  CollectionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 08/09/2021.
//

import UIKit

final class ItenaryInfoCollectionCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var collectionView : UICollectionView!
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.itenaryInfoCollectionCell.name, bundle: nil)
    }
    
    var selectedDays : Days?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        renderView()
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
            cell.configureCell(label: "Phone Number", context: selectedDays!.phoneNumber)
            return cell
        case 1:
            cell.configureCell(label: "Website", context: selectedDays!.website)
            return cell
        default:
            return cell
            
        }
        
    }
    
}
//MARK:- CV Delegate
extension ItenaryInfoCollectionCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
}

extension ItenaryInfoCollectionCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = frame.size.width
        let height = frame.size.height
        return CGSize(width: width * 0.4, height: height * 0.8)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}

extension ItenaryInfoCollectionCell {
    private func renderView() {
        //MARK:- Register CustomCV cells
        collectionView.register(InfoCell.nib(), forCellWithReuseIdentifier: R.reuseIdentifier.infoCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
