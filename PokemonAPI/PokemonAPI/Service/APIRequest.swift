//
//  APIRequest.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

struct Page {
    let offset: Int
    let limit: Int
    
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
    }
}

protocol APIRequest {
    
    associatedtype Response: Decodable
    
    var path: String { get }
    var query: String? { get }
    var paging: Page? { get }
}
