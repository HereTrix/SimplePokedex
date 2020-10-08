//
//  CoreDataManager.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import CoreData

import PokemonAPI

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack

    fileprivate lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        return context
    }()
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SimplePokedex")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    
    func addPokemonsIfNew(from list: [PokemonItem]) {
        let context = backgroundContext
        
        context.perform {
            
            for item in list {
                let request = PKPokemon.fetchRequestFor(name: item.name)
                
                if let _ = try? context.fetch(request).first {
                    continue
                }
                
                let pokemon = PKPokemon(context: context)
                pokemon.name = item.name
                pokemon.id = Int64(item.id)
                
                do {
                    try context.save()
                } catch let error {
                    print("Pokemon save error \(error)")
                }
            }
            
        }
    }
    
    func addPokemonIfNew(name: String, id: Int) {
        let context = backgroundContext

        context.perform {

            let request = PKPokemon.fetchRequestFor(name: name)

            if let _ = try? context.fetch(request).first {
                return
            }

            let pokemon = PKPokemon(context: context)
            pokemon.name = name
            pokemon.id = Int64(id)
            do {
                try context.save()
            } catch let error {
                print("Pokemon save error \(error)")
            }
        }
    }
    
    func update(pokemon model: PokemonModel) {
        let context = backgroundContext
        
        context.perform {
            let request = PKPokemon.fetchRequestFor(name: model.name)
            
            do {
                // TODO: revise pokemon saving
                guard let pokemon = try context.fetch(request).first else {
                    return
                }
                
                pokemon.id = Int64(model.id)
                pokemon.sprites = self.sprite(from: model, in: context)
                
                for type in model.types {
                    let pokemonType = self.type(with: type, in: context)
                    pokemon.addToTypes(pokemonType)
                }
                
                pokemon.weight = Int64(model.weight)
                pokemon.height = Int64(model.height)
                
                try context.save()
            } catch let error {
                print("Pokemon update error: \(error)")
            }
        }
    }
    
    private func sprite(from model: PokemonModel, in context: NSManagedObjectContext) -> PKSprites {
        let sprite = PKSprites(context: context)
        sprite.frontDefault = model.frontDefault
        sprite.frontShiny = model.frontShiny
        sprite.frontFemale = model.frontFemale
        sprite.frontShinyFemale = model.frontShinyFemale
        sprite.backDefault = model.backDefault
        sprite.backShiny = model.backShiny
        sprite.backFemale = model.backFemale
        sprite.backShinyFemale = model.backShinyFemale
        return sprite
    }
    
    private func type(with name: String, in context: NSManagedObjectContext) -> PKType {
        let request = PKType.fetchRequestFor(name: name)
        
        guard let type = try? context.fetch(request).first else {
            
            let type = PKType(context: context)
            type.name = name
            return type
        }
        
        return type
    }
}

// MARK: - Data fetching helpers
extension CoreDataManager {
    
    func pokemonListFetchResultsController() -> NSFetchedResultsController<PKPokemon> {
        
        let fetchRequest: NSFetchRequest<PKPokemon> = PKPokemon.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: persistentContainer.viewContext,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }
    
    func pokemon(with name: String, result: @escaping (PKPokemon?)->Void) {
        
        persistentContainer.viewContext.perform {
            let request = PKPokemon.fetchRequestFor(name: name)
            
            let pokemon = try? self.persistentContainer.viewContext.fetch(request).first
            result(pokemon)
        }
    }
}
