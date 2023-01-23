//
//  GoogleSearchItemViewModel.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import Foundation
import Combine

class SearchItemViewModel {
    let title: String
    let displayLink: String
    let overview: String
    let thumbnailLink: URL?
    
    init(item: SearchItem) {
        self.title = item.title
        self.displayLink = item.displayLink ?? "No available link"
        self.overview = item.snippet ?? "No available description"
        self.thumbnailLink = URL(string: item.thumbnailLink ?? "")
    }
}
