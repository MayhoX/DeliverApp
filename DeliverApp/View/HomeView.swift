//
//  HomeView.swift
//  DeliverApp
//
//  Created by Evan Wong on 16/1/2024.
//

import SwiftUI
import Firebase


struct HomeView: View {
    @State var isSheetPresented: Bool = false
    @StateObject var shopViewModel = ShopViewModel()
    @State private var selectedShop: Shop?
    @EnvironmentObject var userViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if !shopViewModel.shops.isEmpty {
                    ShopListView(shops: shopViewModel.shops, onShopSelected: { shop in
                        selectedShop = shop
                    })
                    .sheet(item: $selectedShop) { selectedShop in
                        ShopDetailView(shop: selectedShop)
                    }
                } else {
                    Text("Loading shops...")
                }
            }
            .toolbar {
                ToolbarItem {
                    if (userViewModel.currentUser?.state == "admin"){
                        Button {
                            Task {
                                await shopViewModel.fetchShops()
                            }
                            self.isSheetPresented = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                AddDeliveryShopSheetView(isSheetPresented: $isSheetPresented)
            }
            .onAppear {
                Task {
                    await shopViewModel.fetchShops()
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
