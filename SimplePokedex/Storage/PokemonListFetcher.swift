//
//  PokemonListFetcher.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation
import CoreData

protocol PokemonListFetcherDelegate: class {
    func addedItem(at: Int)
    func removedItem(at: Int)
    func updatedItem(at index: Int)
    func updatedItems()
}

class PokemonListFetcher: NSObject {
    fileprivate let fetchResultsController: NSFetchedResultsController<PKPokemon>
    
    weak var delegate: PokemonListFetcherDelegate?
    
    fileprivate var inserts: [Int] = []
    
    override init() {
        fetchResultsController = CoreDataManager.shared.pokemonListFetchResultsController()
        super.init()
        fetchResultsController.delegate = self
        reload()
    }
    
    func itemsCount() -> Int {
        fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func item(at index: Int) -> PKPokemon {
        return fetchResultsController.fetchedObjects![index]
    }
    
    func reload() {
        do {
            try fetchResultsController.performFetch()
        } catch let error {
            print("Pokemon list is not fetched: \(error)")
        }
    }
    
    func filter(with query: String) {
        if query.count == 0 {
            fetchResultsController.fetchRequest.predicate = nil
        } else {
            fetchResultsController.fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
        }
        try? fetchResultsController.performFetch()
        delegate?.updatedItems()
    }
}

extension PokemonListFetcher: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let index = newIndexPath?.row else {
                return
            }
            delegate?.addedItem(at: index)
        case .delete:
            guard let index = indexPath?.row else {
                return
            }
            delegate?.removedItem(at: index)
        case .update:
            guard let index = indexPath?.row else {
                return
            }
            delegate?.updatedItem(at: index)
        default:
            break
        }
    }
}
