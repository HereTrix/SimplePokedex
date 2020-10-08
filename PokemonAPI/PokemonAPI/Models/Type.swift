//
//  Type.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

public struct Type: Decodable {
    public let slot: Int
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
    
    enum TypeCodingKey: String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        slot = try values.decode(Int.self, forKey: .slot)
        
        let typeValues = try values.nestedContainer(keyedBy: TypeCodingKey.self, forKey: .type)
        name = try typeValues.decode(String.self, forKey: .name)
    }
}
