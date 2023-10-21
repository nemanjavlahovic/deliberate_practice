//
//  ItemDetailViewModel.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import Foundation

final class ItemDetailViewModel: ObservableObject {
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
}
