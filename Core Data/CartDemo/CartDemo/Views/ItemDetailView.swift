//
//  ItemDetailView.swift
//  CartDemo
//
//  Created by Nemanja Vlahovic on 17.10.23..
//

import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel: ItemDetailViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding(.bottom, 16)
            
            CachedAsyncImage(url: URL(string: viewModel.product.thumbnailURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.product.title)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.black)
                Text(String(format: "$%.2f", viewModel.product.price))
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.gray)
                Text(viewModel.product.subtitle)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(viewModel: ItemDetailViewModel(product: .mocked()))
    }
}
