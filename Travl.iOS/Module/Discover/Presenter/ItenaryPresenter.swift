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
    
    func getItenaries(forLocation location: String) async throws {
        let itenaries = try await discoverInteractor.fetchItenaries(location)
        delegate?.presentItenaryData(_ItenaryPresenter: self, with: itenaries.itenaries.days)
    }
}
