//
//  APIService.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

public class APIService {
    
    public static let service = APIService()
    private let networkService: NetworkService
    
    public let pageLimit = 200
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    public func fetchPokemon(name: String, completion: @escaping (Pokemon?)-> Void) {
        
        let request = PokemonRequest(name: name)
        networkService.perform(request: request) { (result) in
            switch result {
            case .fail(_):
                completion(nil)
            case .success(let pokemon):
                completion(pokemon)
            }
        }
    }
    
    public func fetchPokemon(id: Int, completion: @escaping (Pokemon?)-> Void) {
        let request = PokemonRequest(id: id)
        networkService.perform(request: request) { (result) in
            switch result {
            case .fail(_):
                completion(nil)
            case .success(let pokemon):
                completion(pokemon)
            }
        }
    }
    
    public func fetchPokemonList(page: Int, completion: @escaping ([PokemonListItem]?)-> Void) {
        let request = PokemonListRequest(offset: page * pageLimit, limit: pageLimit)
        networkService.perform(request: request) { (result) in
            switch result {
            case .fail(_):
                completion(nil)
            case .success(let pokemons):
                completion(pokemons.results)
            }
        }
    }
}
