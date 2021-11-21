//
//  DiscoverPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 26/09/2021.
//

import Foundation

protocol BaseDiscoverPresenterDelegate : AnyObject {
    func presentLocation(data : [Location])
    func presentToNextScreen(atCellNumber : Int)
}

final class BaseDiscoverPresenter {
    
    weak var delegate : BaseDiscoverPresenterDelegate?
    
    func setViewDelegate(delegate : BaseDiscoverPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getLocations() {
        NetworkManager.shared.getLocations { [weak self] location in
            switch location {
                
            case .success(let locations):
                self?.delegate?.presentLocation(data : locations )
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func didTapLocation(atIndex : Int) {
        delegate?.presentToNextScreen(atCellNumber: atIndex)
    }
}
