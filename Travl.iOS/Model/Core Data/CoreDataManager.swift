//
//  CoreDataManager.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 15/12/2021.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    var context = Constants.accessManageObjectContext
    
    func saveObjectContext(_ object : NSManagedObject, completion : @escaping (()->Void)) {
        do {
            try context.save()
            completion()
        } catch {
            print("Error in saving object in Context : \(error.localizedDescription)")
        }
    }
    
    func removeObjectContext(_ object : NSManagedObject, completion : @escaping (()->Void)) {
        context.delete(object)
        saveObjectContext(object, completion: {})
    }
    
    func fetchObjectContext<T:NSManagedObject>(_ object : T.Type, withPredicate predicate : NSPredicate? = nil, completion: @escaping ((Result<[NSFetchRequestResult], Error>)->Void)) {

        let request = T.fetchRequest()
        request.predicate = predicate
        do {
            let fetchedObject = try context.fetch(request)
            completion(.success(fetchedObject))
        } catch {
            print("Error in fetching data from Context : \(error.localizedDescription)")
            completion(.failure(error.localizedDescription as! Error ))
        }
    }
}
