//
//  PlannerTableCollectionCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 14/11/2021.
//

import UIKit

protocol PlannerActivityContentCellDelegate  : AnyObject {
    func didSelectAtContent(_ plannerActivityContentCell : PlannerActivityContentCell, indexPath : IndexPath)
}
final class PlannerActivityContentCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var activityContentCollectionView: UICollectionView!
    
    //MARK: - Variables
    weak var delegate : PlannerActivityContentCellDelegate?
    
    let menuLabel = ["Add Activities", "Files"]
    let iconImage = ["plus.circle.fill", "folder.fill"]
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        renderView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.plannerActivityContentCell.name, bundle: nil)
    }
    
    func setViewDelegate(delegate : PlannerActivityContentCellDelegate) {
        self.delegate = delegate
    }
    
}

//MARK: - CV Datasource
extension PlannerActivityContentCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuList = menuLabel[indexPath.row]
        let iconList = iconImage[indexPath.row]
        let cell =  activityContentCollectionView.dequeueReusableCell(withReuseIdentifier: R.nib.menuCollectionCell.identifier, for: indexPath) as! MenuCollectionCell
        cell.setCell(icon: iconList, label: menuList)
        return cell
    }
    
}

//MARK: - CV Delegate
extension PlannerActivityContentCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectAtContent(self, indexPath: indexPath)
        print("Selected at row : \(indexPath.row)")
    }
}

//MARK: - Private methods
extension PlannerActivityContentCell {
    
    private func renderView() {
        let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentView.frame = contentView.frame.inset(by: padding)
        activityContentCollectionView.register(MenuCollectionCell.nib(), forCellWithReuseIdentifier: R.nib.menuCollectionCell.identifier)
        activityContentCollectionView.delegate = self
        activityContentCollectionView.dataSource = self
    }
}
