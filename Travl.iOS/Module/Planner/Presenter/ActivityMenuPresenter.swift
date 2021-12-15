//
//  ActivityMenuPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 15/12/2021.
//

import Foundation

protocol ActivityMenuPresenterDelegate : AnyObject {
    func presentToTourMenu(_ ActivityMenuPresenter : ActivityMenuPresenter, index : Int)
}

final class ActivityMenuPresenter {
    
    weak private var delegate : ActivityMenuPresenterDelegate?
    
    func setViewDelegate(delegate : ActivityMenuPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didTapActivityMenu(atIndex index: Int) {
        delegate?.presentToTourMenu(self, index: index)
    }
}
