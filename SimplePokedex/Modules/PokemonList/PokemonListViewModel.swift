//
//  PokemonListViewModel.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/6/20.
//

import UIKit

class PokemonListViewModel: PokemonListViewModelType {
    
    var input: PokemonListViewModelInput { return self }
    var output: PokemonListViewModelOutput { return self }
    
    var filter: String = "" {
        didSet {
            listFetcher.filter(with: filter)
        }
    }
    
    fileprivate var listFetcher: PokemonListFetcher
    fileprivate weak var delegate: PokemonListViewModelDelegate?
    
    fileprivate var isPageLoading = false
    
    required init(delegate: PokemonListViewModelDelegate) {
        listFetcher = PokemonListFetcher()
        listFetcher.delegate = self
        self.delegate = delegate
        
        if listFetcher.itemsCount() < PokemonLoader.shared.pageSize {
            loadNextPage()
        }
    }
    
    fileprivate func loadNextPage() {
        isPageLoading = true
        
        let pageSize = PokemonLoader.shared.pageSize
        
        let page = Int(listFetcher.itemsCount() / pageSize)
        
        if page == 0 {
            delegate?.dataLoading(isFinished: false)
        }
        
        PokemonLoader.shared.load(page: page) { [weak self] in
            self?.delegate?.dataLoading(isFinished: true)
            self?.isPageLoading = false
        }
    }
}

extension PokemonListViewModel: PokemonListViewModelOutput {
    
    func itemsCount() -> Int {
        return listFetcher.itemsCount()
    }
    
    func item(at index: Int) -> PokemonListItem {
        let pokemon = listFetcher.item(at: index)
        return PokemonMapper.mapToListItem(pokemon: pokemon)
    }
}

extension PokemonListViewModel: PokemonListViewModelInput {
    
    func displayedItem(at index: Int) {
        
        let item = listFetcher.item(at: index)
        
        // Preload item
        if item.sprites == nil,
           let name = item.name {
            PokemonLoader.shared.load(pokemon: name)
        }
        
        // Prevent from loading few times
        guard filter.count == 0,
            !isPageLoading,
            index > listFetcher.itemsCount() - PokemonLoader.shared.pageSize / 4 else {
            return
        }
        
        loadNextPage()
    }
}

extension PokemonListViewModel: PokemonListFetcherDelegate {
    func updatedItems() {
        delegate?.updatedItems()
    }
    
    func addedItem(at index: Int) {
        delegate?.addedItem(at: index)
    }
    
    func updatedItem(at index: Int) {
        delegate?.updatedItem(at: index)
    }
    
    func removedItem(at index: Int) {
        delegate?.removedItem(at: index)
    }
}
