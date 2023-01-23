//
//  SearchRowView.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import SwiftUI
import Combine

struct SearchRowView: View {
    let model: SearchItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack(alignment: .top, spacing: 20) {
                if let imageLink = model.thumbnailLink {
                    AsyncImage(url: imageLink) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 50, height: 50)
                }
                
                Text(model.title)
                    .font(.system(size: 20, weight: .bold))
            }
            
            Text(model.displayLink)
                .font(.subheadline)
                .underline()
            Text(model.overview)
                .font(.subheadline)
                .foregroundColor(Color(#colorLiteral(red: 0.501960814,
                                                     green: 0.501960814,
                                                     blue: 0.501960814,
                                                     alpha: 1)))
        }
        .padding(12)
    }
}

struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        let searchItem = SearchItem(title: "Preview",
                                    link: nil,
                                    displayLink: "https:\\image",
                                    snippet: "Description",
                                   thumbnailLink: nil)
        return SearchRowView(model: SearchItemViewModel(item: searchItem))
    }
}
