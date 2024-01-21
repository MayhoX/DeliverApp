//
//  ShopDetailView.swift
//  DeliverApp
//
//  Created by Evan Wong on 21/1/2024.
//

import SwiftUI

struct ShopDetailView: View {
    @State var isSheetPresented: Bool = false
    @EnvironmentObject var userViewModel: AuthViewModel
    @StateObject var sitemViewModel = SItemViewModel()
    
    var shop: Shop
    @State var shopID: String

    init(shop: Shop) {
        self.shop = shop
        _shopID = State(initialValue: shop.id)
    }
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(data: shop.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
            }
            
            Text("Name: \(shop.name)")
                .font(.title)
            
            Text("Address: \(shop.address)")
                .font(.subheadline)
            
            Spacer()
            
            
            //to show the list of the item
            
            
            
        }
        .toolbar {
            ToolbarItem {
                if (userViewModel.currentUser?.state == "admin"){
                    Button {
                        Task {
                            await sitemViewModel.fetchShops(shopID: shopID)
                        }
                        
                        self.isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            AddItemSheetView(isSheetPresented: $isSheetPresented, shopID: $shopID)
        }
        .padding()
        .navigationTitle("Shop Detail")
    }
}
