//
//  PokemonListRequest.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

struct PokemonListRequest: APIRequest {
    let path = "pokemon"
    
    let query: String? = nil
    
    let paging: Page?
    
    typealias Response = PokemonList
    
    init(offset: Int, limit: Int) {
        paging = Page(offset: offset, limit: limit)
    }
}
