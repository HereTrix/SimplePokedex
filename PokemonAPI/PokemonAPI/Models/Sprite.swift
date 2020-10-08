//
//  Sprite.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

public struct Sprite: Decodable {
    public let backDefault: String?
    public let backFemale: String?
    public let backShiny: String?
    public let backShinyFemale: String?
    public let frontDefault: String?
    public let frontFemale: String?
    public let frontShiny: String?
    public let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case back_default
        case back_female
        case back_shiny
        case back_shiny_female
        case front_default
        case front_female
        case front_shiny
        case front_shiny_female
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backDefault = try? values.decode(String.self, forKey: .back_default)
        backFemale = try? values.decode(String.self, forKey: .back_female)
        backShiny = try? values.decode(String.self, forKey: .back_shiny)
        backShinyFemale = try? values.decode(String.self, forKey: .back_shiny_female)
        frontDefault = try? values.decode(String.self, forKey: .front_default)
        frontFemale = try? values.decode(String.self, forKey: .front_female)
        frontShiny = try? values.decode(String.self, forKey: .front_shiny)
        frontShinyFemale = try? values.decode(String.self, forKey: .front_shiny_female)
    }
}
