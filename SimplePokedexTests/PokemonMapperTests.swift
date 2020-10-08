//
//  PokemonMapperTests.swift
//  SimplePokedexTests
//
//  Created by Ihor Bochko on 10/8/20.
//

import XCTest

@testable import SimplePokedex

class PokemonMapperTests: XCTestCase {

    var model: PokemonModel!
    
    override func setUpWithError() throws {
        let stat = Stat(name: "hp", value: 5)
        
        model = PokemonModel(id: 0,
                             name: "name",
                             backDefault: "back",
                             backFemale: nil,
                             backShiny: "backShiny",
                             backShinyFemale: "backFemale",
                             frontDefault: "front",
                             frontFemale: nil,
                             frontShiny: nil,
                             frontShinyFemale: nil,
                             types: ["basic"],
                             stats: [stat],
                             weight: 1,
                             height: 2)
    }

    override func tearDownWithError() throws {
    }

    func testMapSprites() {
        
        let result = PokemonMapper.mapSprites(pokemon: model)
        
        // Model has 4 sprites
        XCTAssertTrue(result.count == 4)
        // First sprite should be front
        XCTAssertEqual(result[0], model.frontDefault)
    }

    func testMapCharacteristics() {
        
        let result = PokemonMapper.mapCharacteristics(pokemon: model)
        
        XCTAssertTrue(result.count == 4)
        XCTAssertEqual(result[0].name, "TYPE")
        XCTAssertEqual(result[1].name, model.stats[0].name)
        XCTAssertEqual(result[1].value, "\(model.stats[0].value)")
    }
    
    func testPokemonMapping() {
        let context = MockCoreDataStack.shared.managedObjectContext
        
        let pokemon = PKPokemon(context: context)
        pokemon.id = 0
        pokemon.name = "name"

        let sprites = PKSprites(context: context)
        sprites.frontDefault = "f"
        sprites.backDefault = "b"
        sprites.frontShiny = "s"
        sprites.backShiny = "bs"
        sprites.frontFemale = "ff"
        sprites.frontShinyFemale = "fsf"
        sprites.backFemale = "bf"
        sprites.backShinyFemale = "bsf"

        pokemon.sprites = sprites

        let type = PKType(context: context)
        type.name = "t"

        pokemon.types = [type]

        let stat = PKStat(context: context)
        stat.name = "hp"
        stat.base = 5

        pokemon.stats = [stat]
        
        let result = PokemonMapper.map(pokemon: pokemon)
        
        XCTAssertEqual(result.name, pokemon.name)
        XCTAssertEqual(result.id, Int(pokemon.id))
        XCTAssertEqual(result.frontDefault, pokemon.sprites?.frontDefault)
        XCTAssertEqual(result.backDefault, pokemon.sprites?.backDefault)
        XCTAssertEqual(result.frontFemale, pokemon.sprites?.frontFemale)
        XCTAssertEqual(result.backFemale, pokemon.sprites?.backFemale)
        XCTAssertEqual(result.frontShiny, pokemon.sprites?.frontShiny)
        XCTAssertEqual(result.backShiny, pokemon.sprites?.backShiny)
        XCTAssertEqual(result.frontShinyFemale, pokemon.sprites?.frontShinyFemale)
        XCTAssertEqual(result.backShinyFemale, pokemon.sprites?.backShinyFemale)
        
        XCTAssertEqual(result.types[0], type.name)
        
        XCTAssertEqual(result.stats[0].name, stat.name)
        XCTAssertEqual(result.stats[0].value, Int(stat.base))
    }
}
