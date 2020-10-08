//
//  PokemonLoader.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import Foundation

import PokemonAPI

class PokemonLoader {
    
    static var shared = PokemonLoader()
    
    var pageSize: Int {
        return APIService.service.pageLimit
    }
    
    private let pokemonFetchingQueue = DispatchQueue(label: "com.epam.pokemonFetchingQueue")
    
    private var currentPage: Int?
    
    private init() {}
    
    func load(page: Int, completion: @escaping ()->Void) {
        
        // Do not load one page twice
        if let currentPage = currentPage,
           currentPage == page {
            return
        }
        
        currentPage = page
        
        APIService.service.fetchPokemonList(page: page) { items in
            
            guard let items = items else {
                return
            }
            
            let mapped = APIMapper.map(list: items)
            CoreDataManager.shared.addPokemonsIfNew(from: mapped)
            
            for item in items {
                
                self.pokemonFetchingQueue.async {
                    self.load(pokemon: item.name) { _ in
                    }
                }
            }
            self.currentPage = nil
            completion()
        }
    }
    
    func load(pokemon name: String, completion: @escaping (PokemonModel?)->Void) {
        
        APIService.service.fetchPokemon(name: name) { pokemon in
            
            guard let pokemon = pokemon else {
                completion(nil)
                return
            }
            
            let pokemonModel = APIMapper.map(pokemon: pokemon)
            
            CoreDataManager.shared.update(pokemon: pokemonModel)
            
            completion(pokemonModel)
        }
    }
    
    func loadCached(pokemon name: String, completion: @escaping (PokemonModel?)->Void) {
        
        CoreDataManager.shared.pokemon(with: name) { pokemon in
            
            if let pokemon = pokemon,
               pokemon.stats?.count ?? 0 > 0 {
                completion(PokemonMapper.map(pokemon: pokemon))
                return
            }
            
            self.load(pokemon: name, completion: completion)
        }
    }
}
