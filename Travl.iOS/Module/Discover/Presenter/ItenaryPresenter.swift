//
//  ItenaryPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 02/10/2021.
//

import Foundation

protocol ItenaryPresenterDelegate : AnyObject {
    func presentItenaryData(_ItenaryPresenter : ItenaryPresenter, with data : [[Days]])
    func presentFailureMessageFromItenary(_ItenaryPresenter : ItenaryPresenter, error : TError)
}

final class ItenaryPresenter {
    
    weak private var delegate : ItenaryPresenterDelegate?
    private let discoverInteractor = DiscoverInteractor()
    
    func setViewDelegate(delegate : ItenaryPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getItenaries(forLocation location: String) {
        discoverInteractor.fetchItenaries(location) { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.presentItenaryData(_ItenaryPresenter: self!, with: data)
            case .failure(let error):
                print(error.localizedDescription)
                self?.delegate?.presentFailureMessageFromItenary(_ItenaryPresenter: self!, error: error)
            }
        }
    }
}
