//
//  PokemonRequest.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

class PokemonRequest: APIRequest {
    let path = "pokemon"
    
    private(set) var query: String?
    
    let paging: Page? = nil
    
    typealias Response = Pokemon
    
    init(name: String) {
        query = name
    }
    
    init(id: Int) {
        query = "\(id)"
    }
}
