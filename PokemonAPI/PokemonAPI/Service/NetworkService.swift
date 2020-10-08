//
//  NetworkService.swift
//  PokemonAPI
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation

class NetworkService {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    enum Result<T> {
        case success(T)
        case fail(Error)
    }
    
    func perform<T: APIRequest>(request: T, completion: @escaping (Result<T.Response>)-> Void) {
        
        var url = baseURL.appendingPathComponent(request.path)
        
        if let query = request.query {
            url.appendPathComponent(query)
        }
        
        if let page = request.paging {
            url = url.adding(queryItems: page.queryItems)
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else {
                
                if let error = error {
                    completion(.fail(error))
                    return
                }
                return
            }
            
            do {
                let response = try self.decode(type: T.Response.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.fail(error))
            }
        }
        task.resume()
    }
    
    func decode<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
