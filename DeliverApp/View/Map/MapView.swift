//
//  MapView.swift
//  DeliverApp
//
//  Created by Evan Wong on 14/1/2024.
//

import SwiftUI
import GoogleMaps
import CoreLocation



struct MapView: View {
    
    @StateObject private var mapViewModel = MapViewModel()
    @State var isShowingSheet: Bool = false
    
    
    var body: some View {
        MapInfoView(mapViewModel: mapViewModel, isShowingSheet: $isShowingSheet, selectedShop: $mapViewModel.selectedShop)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                mapViewModel.fetchShops()
            }
            .sheet(item: $mapViewModel.selectedShop) { selectedShop in
                            ShopInfoSheetView(shop: selectedShop)
            }
    
        
    }
    
}


#Preview {
    MapView()
}
