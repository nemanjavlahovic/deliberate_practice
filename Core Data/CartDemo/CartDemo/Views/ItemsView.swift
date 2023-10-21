//
//  ItemsView.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import SwiftUI

struct ItemsView: View {
    @ObservedObject var viewModel: ItemsViewModel
    @State private var errorMessage: String? = nil
    @State private var presentDetailView: Bool = false
    @State private var presentErrorMessage: Bool = false
    @State private var selectedProduct: Product?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.products, id: \.self) { product in
                    ProductRow(product: product,
                               coreDataManger: viewModel.coreDataManager,
                               onAddToCart: { product in
                        viewModel.addProductToCart(product: product)
                    }, onUpdateCart: { (product, count) in
                        viewModel.updateProductQuantity(productID: product.id, newQuantity: count)
                    }, onTapGesture: { product in
                        self.selectedProduct = product
                        self.presentDetailView = true
                    })
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.gray.opacity(0.01))
            .navigationTitle("Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CartView(viewModel: CartViewModel(coreDataManager: viewModel.coreDataManager)) {
                            viewModel.loadProducts()
                        }
                    } label: {
                        Image(systemName: "cart")
                            .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                if viewModel.products.isEmpty {
                    Task {
                        do {
                            try await viewModel.fetchProducts()
                        } catch {
                            errorMessage = "Error: \(error.localizedDescription)"
                        }
                    }
                }
            }
            .sheet(isPresented: $presentDetailView) {
                detailView()
            }
            .alert(isPresented: $presentErrorMessage) {
                Alert(title: Text("Error"),
                      message: Text(errorMessage ?? "An unknown error occurred."),
                      dismissButton: .cancel())
            }
        }
    }
    
    @ViewBuilder
    private func detailView() -> some View {
        if let selectedProduct = selectedProduct {
            ItemDetailView(viewModel: ItemDetailViewModel(product: selectedProduct))
        } else {
            /// will never execute since the on tap gesture will be triggered only if there is a product in the list and that product is tapped
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(viewModel: ItemsViewModel(apiService: APIService(), coreDataManager: CoreDataManager()))
    }
}
