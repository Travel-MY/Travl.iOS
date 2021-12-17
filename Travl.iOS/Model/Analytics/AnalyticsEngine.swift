//
//  AnalyticsEngine.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 17/12/2021.
//

import Foundation

enum AnalyticEvents {
    case plannerScreenViewed
    case viewGetInpiredSlider
    case createPlannerScreenView
    case addNewPlanner
    case viewCreatedPlanner(index:Int)
    case plannerDetailsScreenViewed
    case createActivitiesScreenView
    case selectTypeOfActivitiesScreenView
    case addNewActivities
    case viewCreatedActivities(index:Int)
    case viewDiscoverLocations(index : Int, name : String)
    case viewSelectedItenriesFromLocations(index : Int, name : String)
}

// Serialize AnalyticEvent value to prepare it for consumption by Analytic Engine
// 1. Name of the event
extension AnalyticEvents {
    var name : String {
        switch self {
        case .plannerScreenViewed,
                .viewGetInpiredSlider,
                .createPlannerScreenView,
                .plannerDetailsScreenViewed,
                .createActivitiesScreenView,
                .selectTypeOfActivitiesScreenView:
            return String(describing: self)
            
        case   .addNewActivities :
            return "Create New Activities"
        case .addNewPlanner :
            return "Create New Planner"
        case .viewCreatedPlanner:
            return "View New Planner"
        case .viewCreatedActivities:
            return "View New Activities"
        case .viewDiscoverLocations :
            return "View Discover Locations"
        case .viewSelectedItenriesFromLocations:
            return "View Selected Itenaries"
        }
    }
}
// 2. Metadata
extension AnalyticEvents {
    var metadata : [String:String] {
        switch self {
        case .plannerScreenViewed,
                .viewGetInpiredSlider,
                .createPlannerScreenView,
                .addNewPlanner,
                .plannerDetailsScreenViewed,
                .createActivitiesScreenView,
                .selectTypeOfActivitiesScreenView,
                .addNewActivities:
            return [:]
        case .viewCreatedPlanner(index: let index):
            return ["index":"\(index)"]
        case .viewCreatedActivities(index: let index):
            return ["index":"\(index)"]
            
        case .viewDiscoverLocations(index: let index, name: let name):
            return ["index":"\(index)", "name":"\(name)"]
        case .viewSelectedItenriesFromLocations(index: let index, name: let name):
            return ["index":"\(index)", "name":"\(name)"]
            
        }
    }
}

// Engine for the analytics
protocol AnalyticEngine {
    func sendAnalyticsEvent(named name : String, metadata : [String: String])
}
