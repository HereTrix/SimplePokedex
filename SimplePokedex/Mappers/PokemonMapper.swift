//
//  PokemonMapper.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

class PokemonMapper {
    
    class func mapToListItem(pokemon: PKPokemon) -> PokemonListItem {
        
        return PokemonListItem(name: pokemon.name!,
                               imageLink: pokemon.sprites?.frontDefault)
    }
    
    static func mapSprites(pokemon: PokemonModel) -> [String] {
        var sprites: [String] = []
        
        if let sprite = pokemon.frontDefault {
            sprites.append(sprite)
        }
        if let sprite = pokemon.backDefault {
            sprites.append(sprite)
        }
        if let sprite = pokemon.frontFemale {
            sprites.append(sprite)
        }
        if let sprite = pokemon.backFemale {
            sprites.append(sprite)
        }
        if let sprite = pokemon.frontShiny {
            sprites.append(sprite)
        }
        if let sprite = pokemon.backShiny {
            sprites.append(sprite)
        }
        if let sprite = pokemon.frontShinyFemale {
            sprites.append(sprite)
        }
        if let sprite = pokemon.backShinyFemale {
            sprites.append(sprite)
        }
        
        return sprites
    }
    
    static func mapCharacteristics(pokemon: PokemonModel) -> [Characteristic] {
        var characteristics = [Characteristic]()
        
        characteristics.append(Characteristic(name: "TYPE", value: pokemon.types.joined(separator: ", ")))
        
        // Sort stats alphabetically and map
        let stats = pokemon.stats
            .sorted(by: { $0.name < $1.name })
            .map { Characteristic(name: $0.name, value: "\($0.value)") }
        
        characteristics.append(contentsOf: stats)
        
        characteristics.append(Characteristic(name: "WEIGHT", value: "\(pokemon.weight)"))
        characteristics.append(Characteristic(name: "HEIGHT", value: "\(pokemon.height)"))
        
        return characteristics
    }
    
    static func map(pokemon: PKPokemon) -> PokemonModel {
        
        let types = pokemon.types?
            .array
            .map { ($0 as! PKType).name! } ?? []
        
        let stats = pokemon.stats?
            .allObjects
            .map { Stat(name: ($0 as! PKStat).name!, value: Int(($0 as! PKStat).base)) } ?? []
        
        return PokemonModel(id: Int(pokemon.id),
                            name: pokemon.name ?? "",
                            backDefault: pokemon.sprites?.backDefault,
                            backFemale: pokemon.sprites?.backFemale,
                            backShiny: pokemon.sprites?.backShiny,
                            backShinyFemale: pokemon.sprites?.backShinyFemale,
                            frontDefault: pokemon.sprites?.frontDefault,
                            frontFemale: pokemon.sprites?.frontFemale,
                            frontShiny: pokemon.sprites?.frontShiny,
                            frontShinyFemale: pokemon.sprites?.frontShinyFemale,
                            types: types,
                            stats: stats,
                            weight: Int(pokemon.weight),
                            height: Int(pokemon.height)
                            )
    }
}
