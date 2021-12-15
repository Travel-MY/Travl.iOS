//
//  PlannerDetailsPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 15/12/2021.
//

import Foundation
import CoreData

protocol PlannerDetailsPresenterDelegate : AnyObject {
    func presentFetchActivity(_ PlannerDetailsPresenter : PlannerDetailsPresenter, data : [Activity] )
    func presentActivityDetails(_ PlannerDetailsPresenter : PlannerDetailsPresenter, index : Int, section : Int)
}

final class PlannerDetailsPresenter {
    
    weak private var delegate : PlannerDetailsPresenterDelegate?
    private let coreDataManager = CoreDataManager()
    
    func setViewDelegate(delegate : PlannerDetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    func fetchActivities(forDestination destination : String) {
        let predicate = NSPredicate(format: "parentPlanner.destination MATCHES %@", destination)
        coreDataManager.fetchObjectContext(Activity.self, withPredicate: predicate) { [weak self] result in
            switch result {
            case .success(let data):
                let activities = data as! [Activity]
                self?.delegate?.presentFetchActivity(self!, data: activities)
            case .failure(let error):
                break
            }
        }
    }
    
    func removeActivity(_ activity : NSManagedObject) {
        coreDataManager.removeObjectContext(activity, completion: {})
    }
    
    func didTapActivityRow(atIndex index : Int, section : Int) {
        delegate?.presentActivityDetails(self, index: index, section: section)
    }
}
