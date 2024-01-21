//
//  ShopInfoSheetView.swift
//  DeliverApp
//
//  Created by Evan Wong on 21/1/2024.
//

import SwiftUI

struct ShopInfoSheetView: View {
    var shop: Shop
    
    var body: some View {
        VStack {

            if let uiImage = UIImage(data: shop.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 500)
            } else {
                Text("Image not available")
            }
            Text("Name: \(shop.name)")
                .padding(20)
            Text("Address: \(shop.address)")
            
            Spacer()

            .padding()
        }
    }
}

#Preview {
    ShopInfoSheetView(shop: Shop(id: UUID().uuidString, name: "Shop 1", latitude: "1.1", longitude: "1.1", address: "Address 1", image: Data()))
}
