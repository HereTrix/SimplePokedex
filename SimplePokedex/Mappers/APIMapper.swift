//
//  APIMapper.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import Foundation

import PokemonAPI

class APIMapper {
    
    static func map(pokemon: Pokemon) -> PokemonModel {
        return PokemonModel(id: pokemon.id,
                            name: pokemon.name,
                            backDefault: pokemon.sprites.backDefault,
                            backFemale: pokemon.sprites.backFemale,
                            backShiny: pokemon.sprites.backShiny,
                            backShinyFemale: pokemon.sprites.backShinyFemale,
                            frontDefault: pokemon.sprites.frontDefault,
                            frontFemale: pokemon.sprites.frontFemale,
                            frontShiny: pokemon.sprites.frontShiny,
                            frontShinyFemale: pokemon.sprites.frontShinyFemale,
                            types: pokemon.types.map { $0.name},
                            stats: pokemon.stats.map { Stat(name: $0.name, value: $0.baseStat)},
                            weight: pokemon.weight,
                            height: pokemon.height
        )
    }
    
    static func map(list: [PokemonAPI.PokemonListItem]) -> [PokemonItem] {
        return list.map { PokemonItem(name: $0.name, id: $0.id ?? 99999) }
    }
}
