//
//  API.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import Foundation
import Combine

struct API {
    
    let session: URLSession
    
    func fetch<R: Codable>(request: APIRequest) -> AnyPublisher<R, APIError> {
        session
            .dataTaskPublisher(for: request.request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { (data, response) -> AnyPublisher<R, APIError> in                                
                if let response = response as? HTTPURLResponse {
                    if !(200...299).contains(response.statusCode) {
                        return Fail(error: APIError.errorCode(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return Just(data)
                    .decode(type: R.self, decoder: decoder)
                    .mapError { _ in APIError.decodingError }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()        
    }
}
