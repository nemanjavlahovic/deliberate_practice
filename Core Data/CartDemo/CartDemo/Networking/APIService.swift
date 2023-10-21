//
//  APIService.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import Foundation

enum APIError: Error {
    case invalidURL
}

final class APIService {
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw APIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductsResponse.self, from: data)
        return response.products
    }
}
