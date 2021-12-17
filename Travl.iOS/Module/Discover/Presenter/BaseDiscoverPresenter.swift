//
//  DiscoverPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 26/09/2021.
//

import Foundation

protocol BaseDiscoverPresenterDelegate : AnyObject {
    func presentLocation(_BaseDiscoverPresenter : BaseDiscoverPresenter, data : [Location])
    func presentToNextScreen(_BaseDiscoverPresenter : BaseDiscoverPresenter, atCellNumber : Int)
    func presentFailureMessageFromLocation(_BaseDiscoverPresenter : BaseDiscoverPresenter, error : String)
}

final class BaseDiscoverPresenter {
    
    weak private var delegate : BaseDiscoverPresenterDelegate?
    private let discoverInteractor = DiscoverInteractor()
    
    func setViewDelegate(delegate : BaseDiscoverPresenterDelegate) {
        self.delegate = delegate
    }
    func getLocations() {
        discoverInteractor.fetchLocations { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.presentLocation(_BaseDiscoverPresenter: self!, data: data.locations)
            case .failure(let error):
                print(error.localizedDescription)
                self?.delegate?.presentFailureMessageFromLocation(_BaseDiscoverPresenter: self!, error: error.localizedDescription)
            }
        }
    }
    
    func didTapLocation(atIndex : Int) {
        delegate?.presentToNextScreen(_BaseDiscoverPresenter: self, atCellNumber: atIndex)
    }
}
