//
//  CreatePlannerPresenter.swift
//  
//
//  Created by Ikmal Azman on 24/10/2021.
//

import Foundation

protocol CreatePlannerPresenterDelegate : AnyObject {}

final class CreatePlannerPresenter {
    
    weak var delegate : CreatePlannerPresenterDelegate?
    
    func setViewDelegate(delegate : CreatePlannerPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didTapDestination(label : String) {}
    
    
}
