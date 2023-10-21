//
//  ItemsViewModel.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import SwiftUI

final class ItemsViewModel: ObservableObject {
    @Published public var products: [Product] = []
    private let apiService: APIService
    internal let coreDataManager: CoreDataManager
    internal var isDataLoaded = false

    init(apiService: APIService, coreDataManager: CoreDataManager) {
        self.apiService = apiService
        self.coreDataManager = coreDataManager
        withAnimation {
            loadProducts()
        }
    }

    @MainActor
    func fetchProducts() async throws {
        do {
            let fetchedProducts = try await apiService.getProducts()
            withAnimation {
                self.products = fetchedProducts
            }
            coreDataManager.saveProducts(self.products)
        } catch let apiError as APIError {
            // Handle API-specific errors
            throw apiError
        } catch {
            // Handle other errors
            throw error
        }
    }
    
    func loadProducts() {
        self.products = coreDataManager.loadProducts()
    }
    
    func addProductToCart(product: Product) {
        coreDataManager.addProductToCart(product: product)
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
        }
    }

    func updateProductQuantity(productID: Int, newQuantity: Int) {
        coreDataManager.updateProductQuantity(productID: productID, newQuantity: newQuantity)
        self.products = coreDataManager.loadProducts()
    }
}
