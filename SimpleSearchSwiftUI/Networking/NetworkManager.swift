//
//  NetworkManager.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import Foundation
import Combine

protocol NetworkManager {
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue) -> AnyPublisher<T, Error> where T: Decodable
}

extension NetworkManager {
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main) -> AnyPublisher<T, Error> where T: Decodable {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponseType
                }
                
                guard response.statusCode == 200 else {
                    throw NetworkError.invalidResponseCode(response.statusCode)
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
