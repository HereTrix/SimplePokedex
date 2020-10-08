//
//  PokemonList.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

public struct PokemonListItem: Decodable {
    public let name: String
    public let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        
        let url = try values.decode(String.self, forKey: .url)
        
        if let idComponent = url.split(separator: "/").last {
            id = Int(idComponent)
        } else {
            id = nil
        }
    }
}

struct PokemonList: Decodable {
    
    let count: Int
    let results: [PokemonListItem]
}
