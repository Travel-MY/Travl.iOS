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
    
    weak var delegate : ItenaryPresenterDelegate?
    
    func setViewDelegate(delegate : ItenaryPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getItenaries(for location : String) {
        NetworkManager.shared.getItenaries(for: location) { [weak self] data in
            
            switch data {
                
            case .success(let itenaries):
                self?.delegate?.presentItenaryData(with: itenaries)
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
