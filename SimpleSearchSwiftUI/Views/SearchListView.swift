//
//  SearchListView.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import SwiftUI

struct SearchListView: View {
    @ObservedObject var model: SearchListViewModel
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    SearchBarView(text: $model.searchText)
                    ForEach(model.items, id: \.self) {
                        SearchRowView(model: SearchItemViewModel(item: $0))
                    }
                    
                    if !model.items.isEmpty {
                        ProgressView()
                            .onAppear(perform: {
                                model.searchItems(model.searchText)
                            })
                    }
                }
            }
            .navigationBarTitle("Search with Google")
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(model: SearchListViewModel())
    }
}
