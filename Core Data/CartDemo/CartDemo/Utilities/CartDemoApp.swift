//
//  CartDemoApp.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import SwiftUI

@main
struct CartDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ItemsView(viewModel: ItemsViewModel(apiService: APIService(), coreDataManager: CoreDataManager()))
        }
    }
}
