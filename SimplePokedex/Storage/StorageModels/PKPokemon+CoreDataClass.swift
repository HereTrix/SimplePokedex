//
//  PKPokemon+CoreDataClass.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//
//

import Foundation
import CoreData

@objc(PKPokemon)
public class PKPokemon: NSManagedObject {

    static func fetchRequestFor(name: String) -> NSFetchRequest<PKPokemon> {
        let request: NSFetchRequest<PKPokemon> = PKPokemon.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        return request
    }
}
