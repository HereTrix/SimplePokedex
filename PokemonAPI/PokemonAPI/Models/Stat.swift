//
//  Stat.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

public struct Stat: Decodable {
    public let baseStat: Int
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case base_stat
        case stat
    }
    
    enum StatCodingKeys: String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        baseStat = try values.decode(Int.self, forKey: .base_stat)
        
        let statValues = try values.nestedContainer(keyedBy: StatCodingKeys.self, forKey: .stat)
        name = try statValues.decode(String.self, forKey: .name)
    }
}
