//
//  ItenaryDetails.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 03/09/2021.
//

import UIKit

final class ItenaryDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    
    //MARK: - Variables
    var selectedItenary : Days?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    //MARK: - Action
    @IBAction func cancelButtonTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TV DataSource
extension ItenaryDetailsVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let forItenary = selectedItenary else { fatalError("selectedItenary was found nil")}
        
        switch indexPath.section {
        case 0:
             let cell = detailsTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.descriptionCell.identifier, for: indexPath) as! DescriptionCell
            cell.configureCell(with: forItenary.description)
            return cell
            
        case 1:
             let cell = detailsTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.collectionCell.identifier, for: indexPath) as! ItenaryInfoCollectionCell
            cell.configureCell(with: forItenary)
            return cell
            
        case 2 :
           let cell = detailsTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mapPreviewCell.identifier, for: indexPath) as! MapPreviewCell
            cell.configureCell(with: forItenary)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - TV Delegate
extension ItenaryDetailsVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            performSegue(withIdentifier: R.segue.itenaryDetailsVC.goToMap.identifier, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ItenaryMapViewVC else {return}
        destinationVC.logitude = selectedItenary?.coordinate.lon
        destinationVC.latitude = selectedItenary?.coordinate.lat
        destinationVC.locationName = selectedItenary?.locationName
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Description"
        } else if section == 1 {
            return "Contact Details"
        } else {
            return "Get Directions"
        }
    }
}

//MARK: - Private Methods
extension ItenaryDetailsVC {
    
    private func renderView() {
        locationLabel.text = selectedItenary?.locationName
        streetAddressLabel.text = selectedItenary?.address
        
        //MARK: - Register Custom TV
        detailsTableView.register(DescriptionCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.descriptionCell.identifier)
        detailsTableView.register(ItenaryInfoCollectionCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.collectionCell.identifier)
        detailsTableView.register(MapPreviewCell.nib(), forCellReuseIdentifier: R.reuseIdentifier.mapPreviewCell.identifier)
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.rowHeight = 150
        detailsTableView.separatorStyle = .none
        
        locationLabel.textColor = .secondaryLightTurqoise
        streetAddressLabel.textColor = .subtitleGrayLabel
    }
}
