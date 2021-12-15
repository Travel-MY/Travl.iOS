//
//  TourMenuPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 15/12/2021.
//

import Foundation
import CoreData

protocol TourMenuPresenterDelegate : AnyObject {
    func presentActionForSaveTap(_ TourMenuPresenter : TourMenuPresenter)
    func presentFetchParentPlanner(_ TourMenuPresenter : TourMenuPresenter, data : Planner)
}

final class TourMenuPresenter {
    
    weak private var delegate : TourMenuPresenterDelegate?
    private let coreDataManager = CoreDataManager()
    
    func setViewDelegate(delegate : TourMenuPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didSaveButtonTap() {
        delegate?.presentActionForSaveTap(self)
    }
    
    func saveNewActivity(category : String,name : String, address : String, startDate : String, endDate : String, parentPlanner : Planner, phoneNumber : String, website : String, notes : String) {
        let activity = Activity(context: coreDataManager.context)
        activity.category = category
        activity.name = name
        activity.address = address
        activity.startDate = startDate
        activity.endDate = endDate
        activity.parentPlanner = parentPlanner
        activity.phoneNumber = phoneNumber
        activity.website = website
        activity.notes = notes
        coreDataManager.saveObjectContext(activity, completion: {})
    }
    
    func fetchParentPlanner(_ destinationName : String) {
        print("KEY : \(destinationName)")
        
        let predicate = NSPredicate(format: "destination MATCHES %@", destinationName)
        coreDataManager.fetchObjectContext(Planner.self, withPredicate: predicate) { [weak self] result in
            switch result {
            case .success(let data):
                print("PARENT : \(data.first!)")
                let parentPlanner = data.first as! Planner
                self?.delegate?.presentFetchParentPlanner(self!, data: parentPlanner)
            case .failure(_):
                break
            }
        }
//        let predicate = NSPredicate(format: "destination MATCHES %@", "\(destinationName)")
//        coreDataManager.fetchObjectContext(Planner.self, withPredicate: predicate) { [weak self] result in
//            switch result {
//            case .success(let data):
//                let parentPlanner = data.first as! Planner
//
//                print("PARENT PLANNER = \(parentPlanner)")
//                self?.delegate?.presentFetchParentPlanner(self!, data: parentPlanner)
//            case .failure(let error):
//                print("ERROR in fetching data : \(error.localizedDescription)")
//                break
//            }
//        }
    }
}
