//
//  ShopListView.swift
//  DeliverApp
//
//  Created by Evan Wong on 21/1/2024.
//

import SwiftUI

struct ShopListView: View {
    var shops: [Shop]
    var onShopSelected: (Shop) -> Void

    var body: some View {
        List(shops) { shop in
            NavigationLink(destination: ShopDetailView(shop: shop)) {
                ShopListRowView(shop: shop, onSelected: {
                    onShopSelected(shop)
                })
            }
        }
    }
}

struct ShopListRowView: View {
    var shop: Shop
    var onSelected: () -> Void
    
    var body: some View {
        HStack {
            if let uiImage = UIImage(data: shop.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 80) 
            }
            
            VStack(alignment: .leading) {
                Text(shop.name)
                    .font(.headline)
                Text(shop.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            
        }
        .padding()
    }
    
}
