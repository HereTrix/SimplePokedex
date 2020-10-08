//
//  PokemonAPITests.swift
//  PokemonAPITests
//
//  Created by Ihor Bochko on 10/6/20.
//

import XCTest

@testable import PokemonAPI

class PokemonAPITests: XCTestCase {
    
    var api: APIService!
    
    override func setUpWithError() throws {
        api = APIService(networkService: NetworkMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPokemonByName() throws {
        
        let promise = expectation(description: "Pokemon received")
        
        api.fetchPokemon(name: "bulbasaur") { pokemon in
            guard let pokemon = pokemon else {
                XCTFail("Pokemon not parsed")
                return
            }
            
            XCTAssertFalse(pokemon.types.isEmpty, "There is at least one type")
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testPokemonFetchByID() throws {
        let promise = expectation(description: "Pokemon received")
        
        api.fetchPokemon(id: 1) { pokemon in
            guard let pokemon = pokemon else {
                XCTFail("Pokemon not parsed")
                return
            }
            
            XCTAssertFalse(pokemon.types.isEmpty, "There is at least one type")
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }

    func testPokemonList() throws {
        let promise = expectation(description: "Pokemon received")
        
        api.fetchPokemonList(page: 0) { (list) in
            guard let list = list else {
                XCTFail("List not parsed")
                return
            }
            
            XCTAssertFalse(list.isEmpty, "There is at least one pokemon")
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }

}
