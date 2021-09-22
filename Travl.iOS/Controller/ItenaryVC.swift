//
//  DiscoverDetail.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/08/2021.
//

import UIKit
import FloatingPanel

protocol ItenaryVCDelegate : AnyObject {
    func didSendItenaryData(_ itenaryVC : ItenaryVC, with itenary : [[Days]])
    func didSendLocationData(_ itenaryVC : ItenaryVC, with location : Location) 
}

final class ItenaryVC : UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK:- Variables
    var imageURL : URL?
    var locationName: Location?
    
    weak var delegate : ItenaryVCDelegate?
    
    private var fpc : FloatingPanelController!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Call API for data
        getItenaries(at: locationName!.itenaryName)
    }
    
    //MARK:- Action
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // Saved Itenary In Core Data
    }
    
}

//MARK:- Floating Panel Delegate
extension ItenaryVC : FloatingPanelControllerDelegate {}

//MARK:- Floating Panel Layout
extension ItenaryVC : FloatingPanelLayout {
    
    var position: FloatingPanelPosition {
        .bottom
    }
    
    var initialState: FloatingPanelState {
        .tip
    }
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return   [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}

//MARK:- Private methods
extension ItenaryVC {
    
    private func setupView() {
        
        backgroundImage.downloaded(from: imageURL!)
        backgroundImage.contentMode = .scaleAspectFill
        // Passing data to itenaryFP
        delegate?.didSendLocationData(self, with: locationName!)
    }
    
    private func setupCard() {
        guard let itenaryFlotingPanelVC = storyboard?.instantiateViewController(identifier: R.storyboard.discover.itenaryPanel.identifier) as? ItenaryBottomVC else { return}
        // Initliase delegate to Floating Panel, create strong reference to Panel
        self.delegate = itenaryFlotingPanelVC
        
        fpc = FloatingPanelController()
        fpc.set(contentViewController: itenaryFlotingPanelVC)
        fpc.addPanel(toParent: self)
        fpc.delegate = self
        // declare layout to self with weak ARC, instead of self
        fpc.layout = ItenaryVC() as FloatingPanelLayout
    }
    
    private func getItenaries(at itenaries : String = "Melaka") {
        
        NetworkManager.shared.getItenaries(for: itenaries) { [weak self] itenary in
            
            switch itenary {
            
            case .success(let itenary):
                // print(itenary)
                DispatchQueue.main.async { [weak self] in
                    // Passing data to itenaryFP
                    self?.delegate?.didSendItenaryData(self! , with: itenary)
                }
                print(itenaries.count)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
