//
//  ProductRow.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    let onAddToCart: (Product) -> Void
    let onUpdateCart: (Product, Int) -> Void
    let onTapGesture: (Product) -> Void
    @State private var quantity: Int
    private let coreDataManager: CoreDataManager

    init(product: Product,
         coreDataManger: CoreDataManager,
         onAddToCart: @escaping (Product) -> Void,
         onUpdateCart: @escaping (Product, Int) -> Void,
         onTapGesture: @escaping (Product) -> Void) {
        self.product = product
        self.coreDataManager = coreDataManger
        self.onAddToCart = onAddToCart
        self.onUpdateCart = onUpdateCart
        self.onTapGesture = onTapGesture
        self._quantity = State(initialValue: product.quantity)
    }

    var body: some View {
        HStack(alignment: .center) {
            CachedAsyncImage(url: URL(string: product.thumbnailURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 58, maxHeight: 58)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black)
                Text(String(format: "$%.2f", product.price))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                Text(product.subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
            }
            .padding(.leading, 16)
            .onTapGesture {
                onTapGesture(product)
            }
            
            Spacer()
            
            if product.quantity > 0 {
                HStack {
                    Text("\(quantity)")
                    Stepper("\(quantity)", value: $quantity, in: 0...99)
                        .onChange(of: quantity) { newQuantity in
                            onUpdateCart(product, newQuantity)
                        }
                        .frame(maxWidth: 100)
                }
            } else {
                Button("Add to cart") {
                    onAddToCart(product)
                    quantity = 1
                }
                .padding(12)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .frame(maxHeight: 30)
                .padding(.trailing, 32)
            }
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: .mocked(),
                   coreDataManger: CoreDataManager()) { product in
            /// previews only
        } onUpdateCart: { product, count in
            /// previews only
        } onTapGesture: { product in
            /// previews only
        }
    }
}
