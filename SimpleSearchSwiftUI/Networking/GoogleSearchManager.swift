//
//  GoogleSearchManager.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import Foundation
import Combine

class GoogleSearchManager {
    private let apiKey = "AIzaSyADboFllxKL5G1v5gJpVpOilvuXGYZNi9E"
    private let searchEngineId = "25dca554c0a474cb5"
    
    fileprivate lazy var baseUrl: URL? = {
        var domainUrl = URL(string: "https://customsearch.googleapis.com/customsearch/v1")
        let apiKeyQueryItem = URLQueryItem(name: "key", value: apiKey)
        let searchEngineIdQueryItem = URLQueryItem(name: "cx", value: searchEngineId)
        
        return domainUrl?.appending(queryItems: [apiKeyQueryItem, searchEngineIdQueryItem])
    }()
}

extension GoogleSearchManager: NetworkManager {
    func search(_ text: String, pageNumber: Int) -> AnyPublisher<SearchList, Error> {
        guard let searchRequest = URLRequest.createSearchRequest(baseUrl: baseUrl,
                                                                 searchText: text,
                                                                 page: pageNumber) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return execute(searchRequest, decodingType: GoogleSearchResponse.self)
            .map { $0.convert() }
            .eraseToAnyPublisher()
    }
}

fileprivate extension URLRequest {
    static func createSearchRequest(baseUrl: URL?, searchText: String, page: Int) -> URLRequest? {
        let queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "start", value: String(page))
        ]

        guard let finalUrl = baseUrl?.appending(queryItems: queryItems) else {
            return nil
        }
        
        return URLRequest(url: finalUrl)
    }
}
