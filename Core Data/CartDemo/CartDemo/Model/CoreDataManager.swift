//
//  CoreDataManager.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import CoreData

final class CoreDataManager {
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }

    // Add Product to Cart
    func addProductToCart(product: Product) {
        let fetchRequest: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", product.id)
        
        if let existingProduct = try? context.fetch(fetchRequest).first {
            existingProduct.quantity += 1
        } else {
            let productEntity = ProductModel(context: context)
            productEntity.id = Int16(product.id)
            productEntity.title = product.title
            productEntity.subtitle = product.subtitle
            productEntity.price = product.price
            productEntity.quantity = 1
            productEntity.thumbnail = product.thumbnailURL
        }
        
        try? context.save()
    }

    // Load Cart Products
    func loadCartProducts() -> [Product] {
        return loadProducts().filter { $0.quantity > 0 }
    }

    // Save Products
    func saveProducts(_ products: [Product]) {
        for product in products {
            let productEntity = ProductModel(context: context)
            productEntity.id = Int16(product.id)
            productEntity.title = product.title
            productEntity.subtitle = product.subtitle
            productEntity.thumbnail = product.thumbnailURL
            productEntity.price = product.price
            productEntity.quantity = 0
            
            try? context.save()
        }
    }

    // Load Products
    func loadProducts() -> [Product] {
        let fetchRequest: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        
        do {
            let productEntities = try context.fetch(fetchRequest)
            return productEntities.map {
                Product(id: Int($0.id),
                        title: $0.title ?? "",
                        subtitle: $0.subtitle ?? "",
                        price: $0.price,
                        thumbnailURL: $0.thumbnail ?? "",
                        quantity: Int($0.quantity))
            }
        } catch {
            debugPrint("Failed to fetch products: \(error.localizedDescription)")
            return []
        }
    }

    // Update Product Quantity

    func updateProductQuantity(productID: Int, newQuantity: Int) {
        let fetchRequest: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productID)

        do {
            if let productEntity = try context.fetch(fetchRequest).first {
                productEntity.quantity = Int16(newQuantity)
                try context.save()
            }
        } catch {
            debugPrint("Failed to update product quantity: \(error.localizedDescription)")
        }
    }
}
