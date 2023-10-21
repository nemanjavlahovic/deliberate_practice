//
//  CartView.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    var onDisappearHandler: (() -> Void)?

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.cartProducts, id: \.self) { product in
                    ProductRow(product: product,
                               coreDataManger: viewModel.coreDataManager, onAddToCart: { _ in
                        /// can't be triggered here as whenever the count is 0 it is removed from the list
                    }, onUpdateCart: { (product, count) in
                        viewModel.updateProductQuantity(productID: product.id, newQuantity: count)
                    }, onTapGesture: { product in
                        /// if it should be presented from cart view as well, logic from items view should be here too
                    })
                }
                .onDelete(perform: viewModel.deleteProductFromCart)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.gray.opacity(0.01))
            .navigationTitle("Cart")
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Items")
                        .font(.system(size: 12, weight: .medium))
                    Spacer()
                    Text("\(viewModel.numberOfProducts)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Grand Total")
                        .font(.system(size: 20, weight: .medium))
                    Spacer()
                    Text("$\(viewModel.totalPriceForItems, specifier: "%.2f")")
                        .foregroundColor(.secondary)

                }
            }
            .padding()
            .padding(.horizontal, 32)

        }
        .onDisappear {
            onDisappearHandler?()
        }
    }    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView(viewModel: CartViewModel(coreDataManager: CoreDataManager()))            
        }
    }
}
