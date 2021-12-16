//
//  Activity+CoreDataProperties.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 16/12/2021.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var address: String
    @NSManaged public var category: String
    @NSManaged public var endDate: Date
    @NSManaged public var name: String
    @NSManaged public var notes: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var startDate: Date
    @NSManaged public var website: String?
    @NSManaged public var parentPlanner: Planner?

}

extension Activity : Identifiable {

}
