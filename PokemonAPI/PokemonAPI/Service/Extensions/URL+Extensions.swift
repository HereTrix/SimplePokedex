//
//  URL+Extensions.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/7/20.
//

import Foundation

extension URL {
    
    func adding(queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        return components.url!
    }
}
