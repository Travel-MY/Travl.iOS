//
//  BasePlannerPresenter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 15/12/2021.
//

import Foundation
import CoreData

protocol BasePlannerPresenterDelegate : AnyObject {
    func presentFetchPlanner(_ BasePlannerPresenter : BasePlannerPresenter, data : [Planner])
    func presentFetchImages(_ BasePlannerPresenter : BasePlannerPresenter, data : [Images])
    func presentToPlannerDetails(_ BasePlannerPresenter : BasePlannerPresenter, index : Int)
    func presentFailureMessageFromImages(_BasePlannerPresenter : BasePlannerPresenter, error : String)
    func presentFailureMessageFromPlanner(_BasePlannerPresenter : BasePlannerPresenter, error : String)
}

final class BasePlannerPresenter {
    
    weak private var delegate : BasePlannerPresenterDelegate?
    private let coreDataManager = CoreDataManager()
    private let plannerInteractor = PlannerInteractor()
    
    func setViewDelegate(delegate : BasePlannerPresenterDelegate) {
        self.delegate = delegate
    }
    
    func fetchPlanner() {
        coreDataManager.fetchObjectContext(Planner.self, withPredicate: nil) { [weak self] result in
            switch result {
            case .success(let data):
                let planners = data as! [Planner]
                self?.delegate?.presentFetchPlanner(self!, data: planners)
            case .failure(let error):
                self?.delegate?.presentFailureMessageFromPlanner(_BasePlannerPresenter: self!, error: error.localizedDescription)
            }
        }
    }
    
    func removePlanner(_ planner : Planner) {
        coreDataManager.removeObjectContext(planner, completion: {})
    }
    
    func fetchImages() async throws {
        let imageResponse = try await plannerInteractor.fetchFooterImages()
        delegate?.presentFetchImages(self, data: imageResponse.images)
    }
    
    func didTapPlannerRow(atIndex index : Int) {
        delegate?.presentToPlannerDetails(self, index: index)
    }
}
