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
}

class ItenaryVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var imageURL : URL!
    var locationDetails: Location!
    var itenaries = [[Days]]()
    
    weak var delegate : ItenaryVCDelegate?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        setupView()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // Saved Itenary In Core Data
    }
    
}

//MARK:- Network Request
extension ItenaryVC {
    
    func getItenaries(at itenaries : String = "Melaka"){
        NetworkManager.shared.getItenaries(for: itenaries) { [weak self] itenary in
            switch itenary {
            
            case .success(let itenary):
                // print(itenary)
                DispatchQueue.main.async {
                    self?.itenaries.append(contentsOf: itenary)
                    self?.delegate?.didSendItenaryData(self! , with: itenary)
                }
                
                print(itenaries.count)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

//MARK:- Private methods
extension ItenaryVC {
    
    private func setupView() {
        backgroundImage.downloaded(from: imageURL)
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    private func setupCard() {
        guard let itenaryFlotingPanelVC = storyboard?.instantiateViewController(identifier: "itenaryPanel") as? ItenaryFP else { return}
        // Initliase delegate to Floating Panel, create strong reference to Panel
        self.delegate = itenaryFlotingPanelVC
        // Passing Location to Float Panle
        itenaryFlotingPanelVC.location = locationDetails
        
        let fpc = FloatingPanelController()
        fpc.set(contentViewController: itenaryFlotingPanelVC)
        fpc.addPanel(toParent: self)
        fpc.delegate = self
        fpc.layout = self
    }
}


extension ItenaryVC : FloatingPanelControllerDelegate {
    
}

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

