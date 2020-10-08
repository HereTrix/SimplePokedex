//
//  PokemonListViewModelType.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

protocol PokemonListViewModelOutput {
    
    func itemsCount() -> Int
    func item(at: Int) -> PokemonListItem
}

protocol PokemonListViewModelInput {
    
    func displayedItem(at: Int)
}

protocol PokemonListViewModelType {
    var input: PokemonListViewModelInput { get }
    var output: PokemonListViewModelOutput { get }
    var filter: String { get set }
    
    init(delegate: PokemonListViewModelDelegate)
}

protocol PokemonListViewModelDelegate: class {
    func removedItem(at index: Int)
    func addedItem(at index: Int)
    func updatedItem(at index: Int)
    func updatedItems()
    func dataLoading(isFinished: Bool)
}
