//
//  CreatePlannerPresenter.swift
//  
//
//  Created by Ikmal Azman on 24/10/2021.
//

import Foundation

protocol CreatePlannerPresenterDelegate : AnyObject {
    func presentActionForCreatePlanner(_ CreatePlannerPresenter : CreatePlannerPresenter)
}

final class CreatePlannerPresenter {
    
    weak private var delegate : CreatePlannerPresenterDelegate?
    private var coreDataManager = CoreDataManager()
    
    func setViewDelegate(delegate : CreatePlannerPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didTapCreatePlanner(_ destination : String,_ startDate : String,_ endDate : String) {
        // Store data to plist as reference to pass data to unrelated VC
        UserDefaults.standard.set(destination, forKey: Constants.UserDefautlsKey.primaryKeyForPlanner)
        let newPlanner = Planner(context: coreDataManager.context)
        newPlanner.destination = destination
        newPlanner.startDate = startDate
        newPlanner.endDate = endDate
        coreDataManager.saveObjectContext(newPlanner, completion:{})
        print("NEW Planner : \(newPlanner)")
        delegate?.presentActionForCreatePlanner(self)
    }
    
    
}
