//
//  ItenaryPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 02/10/2021.
//

import Foundation

protocol ItenaryPresenterDelegate : AnyObject {
    func presentItenaryData(with data : [[Days]])
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
                self?.delegate?.presentItenaryData(with: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
