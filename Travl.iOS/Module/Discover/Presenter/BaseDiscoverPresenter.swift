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
    
    weak private var delegate : BaseDiscoverPresenterDelegate?
    private let discoverInteractor = DiscoverInteractor()
    
    func setViewDelegate(delegate : BaseDiscoverPresenterDelegate) {
        self.delegate = delegate
    }
    func getLocations() {
        discoverInteractor.fetchLocations { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.presentLocation(data: data.locations)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didTapLocation(atIndex : Int) {
        delegate?.presentToNextScreen(atCellNumber: atIndex)
    }
}
