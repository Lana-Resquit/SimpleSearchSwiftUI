//
//  GoogleSearchViewModel.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import Foundation
import Combine

class SearchListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var items: [SearchItem] = []

    private let searchManager = GoogleSearchManager()
    private var cancellable: Set<AnyCancellable> = []
    private var nextPageIndex: Int?
    
    init() {
        $searchText
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap {
                if $0.isEmpty || $0 == " " {
                    self.items = []
                    self.nextPageIndex = 1
                    return nil
                }
                
                return $0
            }
            .sink(receiveValue: { [self] (text) in
                searchItems(text)
            })
            .store(in: &cancellable)
    }
    
    func searchItems(_ text: String) {
        searchManager.search(text, pageNumber: nextPageIndex ?? 1)
            .receive(on: RunLoop.main)
            .sink { (completed) in
                if case .failure(let error) = completed {
                    print("Failed \(error)")
                }
            } receiveValue: { [self] (searchResult) in
                items.append(contentsOf: searchResult.items ?? [])
                nextPageIndex = searchResult.nextPageIndex
            }
            .store(in: &cancellable)
    }
}
