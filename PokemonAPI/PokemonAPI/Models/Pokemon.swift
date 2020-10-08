//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

public struct Pokemon: Decodable {
    public let id: Int
    public let name: String
    public let sprites: Sprite
    public let types: [Type]
    public let weight: Int
    public let height: Int
    public let stats: [Stat]
}
