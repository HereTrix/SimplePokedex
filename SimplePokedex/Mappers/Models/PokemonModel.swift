//
//  PokemonModel.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import Foundation

struct Characteristic {
    let name: String
    let value: String
}

struct Stat {
    let name: String
    let value: Int
}

struct PokemonModel {
    public let id: Int
    public let name: String
    public let backDefault: String?
    public let backFemale: String?
    public let backShiny: String?
    public let backShinyFemale: String?
    public let frontDefault: String?
    public let frontFemale: String?
    public let frontShiny: String?
    public let frontShinyFemale: String?
    public let types: [String]
    public let stats: [Stat]
    public let weight: Int
    public let height: Int
}
