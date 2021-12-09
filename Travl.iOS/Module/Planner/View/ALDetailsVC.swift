//
//  ALDetailsViewController.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 02/12/2021.
//

import UIKit
import CoreLocation

final class ALDetailsVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var activityDetailsTableView : UITableView!
    //MARK: - Variables
    var selectedActivity : Activity?
    var latitude : Double?
    var longitude : Double?
    var coordinate  : CLLocationCoordinate2D?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    //MARK: - Actions
    @IBAction func dismissTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - Datasource
extension ALDetailsVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0 :
            let cell = activityDetailsTableView.dequeueReusableCell(withIdentifier: ActivityListCell.identifier, for: indexPath) as! ActivityListCell
            if let activity = selectedActivity {
                cell.configureCell(data: activity)
            }
            return cell
        case 1 :
            let cell = activityDetailsTableView.dequeueReusableCell(withIdentifier: ActivityInfoCellTableViewCell.identifier, for: indexPath) as! ActivityInfoCellTableViewCell
            if let activity = selectedActivity {
                cell.configureCell(data: activity)
            }
            return cell
        case 2 :
            let cell = activityDetailsTableView.dequeueReusableCell(withIdentifier: MapPreviewCell.identifier, for: indexPath) as! MapPreviewCell
            cell.delegate = self
            if let address = selectedActivity?.address {
                cell.configureCell(fromQuery: address)
            } else {
                cell.removeFromSuperview()
            }
            return cell
        default:
            return UITableViewCell()
            
        }
        
    }
}

//MARK: - Delegate
extension ALDetailsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityDetailsTableView.deselectRow(at: indexPath, animated: true)
        print("Section : \(indexPath.section), ")
        if indexPath.section == 2 {
            let mapPreviewVC : ItenaryMapViewVC = UIStoryboard(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "ItenaryMapViewVC") as! ItenaryMapViewVC
            mapPreviewVC.locationName = selectedActivity?.name
            mapPreviewVC.latitude = latitude
            mapPreviewVC.logitude = longitude
            present(mapPreviewVC, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mapVC = segue.destination as? ItenaryMapViewVC {
            mapVC.latitude = latitude
            mapVC.logitude = longitude
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case 0 :
            return 130
        case 1 :
            return 220
        default:
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "Activity"
        case 1 :
            return "Info"
        case 2 :
            return "Get Directions"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
}

//MARK: - MapPreviewCell Delegate

extension ALDetailsVC : MapPreviewCellDelegate {
    func presentCoordinateFromQuery(_ vc: MapPreviewCell, latitude: Double, longitude: Double, coordinate : CLLocationCoordinate2D) {
        print("LATITUDE : \(latitude), LONGITUDE : \(longitude)")
        self.latitude = latitude
        self.longitude = longitude
    }
}

//MARK: - Private methods
extension ALDetailsVC {
    private func renderView() {
        activityDetailsTableView.register(ActivityInfoCellTableViewCell.nib(), forCellReuseIdentifier: ActivityInfoCellTableViewCell.identifier)
        activityDetailsTableView.register(MapPreviewCell.nib(), forCellReuseIdentifier: MapPreviewCell.identifier)
        activityDetailsTableView.register(ActivityListCell.nib(), forCellReuseIdentifier: ActivityListCell.identifier)
        activityDetailsTableView.separatorStyle = .none
        activityDetailsTableView.dataSource = self
        activityDetailsTableView.delegate = self
    }
}
