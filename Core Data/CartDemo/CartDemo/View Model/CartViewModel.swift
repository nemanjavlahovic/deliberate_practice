//
//  CartViewModel.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import Foundation

final class CartViewModel: ObservableObject {
    internal let coreDataManager: CoreDataManager
    @Published public var cartProducts: [Product] = []

    public var totalPriceForItems: Double {
        return cartProducts.reduce(0) { sum, product in
            return sum + (product.price * Double(product.quantity))
        }
    }

    public var numberOfProducts: Int {
        return cartProducts.reduce(0) { sum, product in
            return sum + product.quantity
        }
    }

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.cartProducts = loadCartProducts()
    }

    @MainActor
    func addProductToCart(product: Product) {
        coreDataManager.addProductToCart(product: product)
    }

    func loadCartProducts() -> [Product] {
        return coreDataManager.loadCartProducts()
    }
        
    func updateProductQuantity(productID: Int, newQuantity: Int) {
        coreDataManager.updateProductQuantity(productID: productID, newQuantity: newQuantity)
        self.cartProducts = coreDataManager.loadCartProducts()
    }

    public func deleteProductFromCart(at offsets: IndexSet) {
        offsets.forEach { index in
            let product = cartProducts[index]
            coreDataManager.updateProductQuantity(productID: product.id, newQuantity: 0)
        }
        self.cartProducts = coreDataManager.loadCartProducts()
    }
}
