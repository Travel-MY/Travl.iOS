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
    //MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - Variables
    var imageURL : URL?
    var locationName: Location?
    
    weak var delegate : ItenaryVCDelegate?
    
    private var presenter = ItenaryPresenter()
    private var fpc : FloatingPanelController!
    private let discoverInteractor = DiscoverInteractor()
    
  
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getItenaries(forLocation: locationName?.itenaryName ?? "")
    }
    
    //MARK: - Action
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // Saved Itenary In Core Data
    }
}

//MARK: - Presenter Delegate
extension ItenaryVC : ItenaryPresenterDelegate {
    func presentItenaryData(with data: [[Days]]) {
        self.delegate?.didSendItenaryData(self, with: data)
    }
}

//MARK: - Floating Panel Delegate
extension ItenaryVC : FloatingPanelControllerDelegate {}

//MARK: - Floating Panel Layout
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

//MARK: - Private methods
extension ItenaryVC {
    
    private func setupView() {
        if let url = imageURL {
            backgroundImage.loadImage(url: url)
        }
        backgroundImage.contentMode = .scaleAspectFill
        // Passing data to itenaryFP
        delegate?.didSendLocationData(self, with: locationName!)
        presenter.setViewDelegate(delegate: self)
    }
    
    private func setupCard() {
        
        guard let itenaryFlotingPanelVC = storyboard?.instantiateViewController(identifier: R.storyboard.discover.itenaryPanel.identifier) as? ItenarySheetVC else { return}
        // Initliase delegate to Floating Panel, create strong reference to Panel
        self.delegate = itenaryFlotingPanelVC
        
        fpc = FloatingPanelController()
        fpc.set(contentViewController: itenaryFlotingPanelVC)
        fpc.addPanel(toParent: self)
        fpc.delegate = self
        // declare layout to self with weak ARC, instead of self
        fpc.layout = ItenaryVC() as FloatingPanelLayout
    }
}
