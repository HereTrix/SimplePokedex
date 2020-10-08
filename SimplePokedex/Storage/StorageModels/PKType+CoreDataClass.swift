//
//  PKType+CoreDataClass.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//
//

import Foundation
import CoreData

@objc(PKType)
public class PKType: NSManagedObject {
    
    static func fetchRequestFor(name: String) -> NSFetchRequest<PKType> {
        let request: NSFetchRequest<PKType> = fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        return request
    }
}
