//
//  SimpleSearchSwiftUIApp.swift
//  SimpleSearchSwiftUI
//
//  Created by Khrystyna Sietaia on 20.01.2023.
//

import SwiftUI

@main
struct SimpleSearchSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            SearchListView(model: SearchListViewModel())
        }
    }
}
