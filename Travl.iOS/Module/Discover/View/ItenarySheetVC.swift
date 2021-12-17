//
//  ItenaryFloatingPanelVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 31/08/2021.
//

import UIKit

final class ItenarySheetVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locDesc: UITextView!
    @IBOutlet weak var itenaryTableView: UITableView!
    @IBOutlet weak var locDescHC: NSLayoutConstraint!
    
    private var itenaries = [[Days]]()
    private var location : Location?
    private var selectedAtSection : Int!
    private var selectedAtRow : Int!
    private let analytic = AnalyticManager(engine: MixPanelAnalyticEngine())
    
    //MARK: - : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.itenaries.removeAll()
        self.location = nil
    }
}

//MARK: - TableView Data source
extension ItenarySheetVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itenaries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itenaries[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItenaryCell = itenaryTableView.dequeueReusableCell(withIdentifier: R.nib.itenaryCell.identifier, for: indexPath) as! ItenaryCell
        let listOfItenaries = itenaries[indexPath.section][indexPath.row]
        cell.cellContent(for: listOfItenaries)
        return cell
    }
}

//MARK: - TableView Delegate
extension ItenarySheetVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAtSection = indexPath.section
        selectedAtRow = indexPath.row
        print("Section \(indexPath.section), at cell \(indexPath.row)")
        // Remove highlight when cell selected
        itenaryTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: R.segue.itenarySheetVC.goToItenaryDetails.identifier, sender: self)
    }
    
    //MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedAtItenary = itenaries[selectedAtSection][selectedAtRow]
        guard let destinationVC = segue.destination as? ItenaryDetailsVC else {return}
        destinationVC.selectedItenary = selectedAtItenary
        analytic.log(.viewSelectedItenriesFromLocations(index: selectedAtRow, name: selectedAtItenary.locationName))
    }
}


//MARK:- ItenaryVC Delegate
extension ItenarySheetVC : ItenaryVCDelegate {
    
    func didSendLocationData(_ itenaryVC: ItenaryVC, with location: Location) {
        DispatchQueue.main.async { [weak self] in
            self?.locationLabel.text = location.locationName
            self?.locDesc.text = location.description
            self?.sloganLabel.text = location.slogan
        }
    }
    
    func didSendItenaryData(_ itenaryVC: ItenaryVC, with itenary: [[Days]]) {
        DispatchQueue.main.async { [weak self] in
            self?.itenaries = itenary
            self?.itenaryTableView.reloadData()
        }
    }
}

//MARK:- Private methods
extension ItenarySheetVC {
    
    private func renderView() {
        view.addRoundedCorners()
        sloganLabel.textColor = .primarySeaBlue
        locationLabel.textColor = .subtitleGrayLabel
        locDesc.textColor = .headingBlackLabel
        
        itenaryTableView.register(UINib(nibName: R.nib.itenaryCell.name, bundle: nil), forCellReuseIdentifier: R.nib.itenaryCell.identifier)
        itenaryTableView.dataSource = self
        itenaryTableView.delegate = self
        
        locDescHC.constant = locDesc.contentSize.height
    }
}
