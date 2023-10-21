//
//  Product.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import Foundation

struct ProductsResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let price: Double
    let thumbnailURL: String
    var quantity: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle = "description"
        case price
        case thumbnailURL = "thumbnail"
    }
}

/// for SwiftUI previews
extension Product {
    static func mocked() -> Product {
        let id = Int.random(in: 1...1000)
        let title = "Random Product \(id)"
        let description = "Description for Product \(id)"
        let price = Double.random(in: 1.0...100.0)
        let thumbnailURL = "https://example.com/thumbnail\(id).jpg"

        return Product(
            id: id,
            title: title,
            subtitle: description,
            price: price,
            thumbnailURL: thumbnailURL
        )
    }
}
