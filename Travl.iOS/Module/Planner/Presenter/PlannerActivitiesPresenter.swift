//
//  PlannerActivitiesPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 29/10/2021.
//

import Foundation

protocol PlannerActivitiesPresenterDelegate : AnyObject {}

final class PlannerActivitiesPresenter {
    
    weak var delegate : PlannerActivitiesPresenterDelegate?
    
    func setViewDelegate(delegate : PlannerActivitiesPresenterDelegate) {
        self.delegate = delegate
    }
}


