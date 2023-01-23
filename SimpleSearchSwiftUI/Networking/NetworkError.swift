//
//  NetworkError.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed(String)
    case generic(String)
    case invalidResponseCode(Int)
    case invalidResponseType
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL encountered. Can't proceed with the request"
        case .invalidResponseType:
            return "Invalid response encountered. Can't proceed with the request"
        case .decodingFailed:
            return "Decoding Error. The data couldn’t be read because it isn’t in the correct format."
        case .generic(let message):
            return message
        case .invalidResponseCode(let responseCode):
            return "Invalid response code encountered from the server. Expected 200, received \(responseCode)"
        }
    }
}
