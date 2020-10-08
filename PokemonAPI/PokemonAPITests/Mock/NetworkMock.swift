//
//  NetworkMock.swift
//  PokemonAPITests
//
//  Created by Ihor Bochko on 10/6/20.
//

import Foundation
@testable import PokemonAPI

class NetworkMock: NetworkService {
    
    enum MockError: Error {
        case noData
    }
    
    override func perform<T: APIRequest>(request: T, completion: @escaping (Result<T.Response>)-> Void) {
        let responseMock = ResponseMock()
        guard let data = responseMock.mock(for: request) else {
            completion(.fail(MockError.noData))
            return
        }
        
        do {
            let response = try self.decode(type: T.Response.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.fail(error))
        }
    }
}
