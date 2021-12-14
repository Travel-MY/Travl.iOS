//
//  Planner+CoreDataProperties.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 12/12/2021.
//
//

import Foundation
import CoreData


extension Planner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planner> {
        return NSFetchRequest<Planner>(entityName: "Planner")
    }

    @NSManaged public var destination: String
    @NSManaged public var endDate: String
    @NSManaged public var startDate: String
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for activities
extension Planner {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension Planner : Identifiable {

}
