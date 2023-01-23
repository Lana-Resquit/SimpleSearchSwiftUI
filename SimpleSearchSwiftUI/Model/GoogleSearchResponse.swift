//
//  GoogleSearchResponse.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import Foundation

struct GoogleSearchResponse: Codable {
    let items: [Item]?
    let queries: Queries
}

struct Queries: Codable {
    struct Page: Codable {
        let startIndex: Int?
    }
    
    let nextPage: [Page]?
}

struct Item: Codable {
    let title: String
    let link: String?
    let displayLink: String?
    let snippet: String?
    let pagemap: Pagemap?
}

struct Pagemap: Codable {
    enum CodingKeys: String, CodingKey {
        case thumbnail = "cse_thumbnail"
    }
    
    let thumbnail: [Thumbnail]?
}

struct Thumbnail: Codable {
    let src: String?
}

extension GoogleSearchResponse {
    func convert() -> SearchList {
        let list = items?.map {
            SearchItem(title: $0.title,
                       link: $0.link,
                       displayLink: $0.displayLink,
                       snippet: $0.snippet,
                       thumbnailLink: $0.pagemap?.thumbnail?.first?.src)
        }
        
        return SearchList(items: list,
                          nextPageIndex: queries.nextPage?.first?.startIndex)
    }
}
