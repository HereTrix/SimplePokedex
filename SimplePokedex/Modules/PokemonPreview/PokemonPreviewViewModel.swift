//
//  PokemonPreviewViewModel.swift
//  SimplePokedex
//
//  Created by Ihor Bochko on 10/7/20.
//

import Foundation

protocol PokemonPreviewViewModelInput {
    func reload()
    func refresh()
}

protocol PokemonPreviewViewModelOutput {
    var pokemonName: String { get }
    var sprites: [String] { get }
    
    func characteristicsCount() -> Int
    func characteristic(at index: Int) -> Characteristic
}

protocol PokemonPreviewViewModelType {
    var input: PokemonPreviewViewModelInput { get }
    var output: PokemonPreviewViewModelOutput { get }
    
    var delegate: PokemonPreviewViewModelDelegate? { set get }
}

protocol PokemonPreviewViewModelDelegate: class {
    func dataLoading(isFinished: Bool)
}

class PokemonPreviewViewModel: PokemonPreviewViewModelType {
    var input: PokemonPreviewViewModelInput { return self }
    var output: PokemonPreviewViewModelOutput { return self }
    
    let pokemonName: String
    var sprites: [String] = []
    
    fileprivate var characteristics: [Characteristic] = []
    
    weak var delegate: PokemonPreviewViewModelDelegate?
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
    }
}

extension PokemonPreviewViewModel: PokemonPreviewViewModelInput {
    func reload() {
        delegate?.dataLoading(isFinished: false)
        PokemonLoader.shared.loadCached(pokemon: pokemonName) { [weak self] model in
            if let model = model {
                self?.characteristics = PokemonMapper.mapCharacteristics(pokemon: model)
                self?.sprites = PokemonMapper.mapSprites(pokemon: model)
            }
            self?.delegate?.dataLoading(isFinished: true)
        }
    }
    
    func refresh() {
        delegate?.dataLoading(isFinished: false)
        PokemonLoader.shared.load(pokemon: pokemonName) { [weak self] model in
            if let model = model {
                self?.characteristics = PokemonMapper.mapCharacteristics(pokemon: model)
            }
            self?.delegate?.dataLoading(isFinished: true)
        }
    }
}

extension PokemonPreviewViewModel: PokemonPreviewViewModelOutput {
    func characteristicsCount() -> Int {
        return characteristics.count
    }
    
    func characteristic(at index: Int) -> Characteristic {
        return characteristics[index]
    }
}
