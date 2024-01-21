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
    
    var body: some View {
//        Map()
//            .edgesIgnoringSafeArea(.top)
        
        MapInfoView(mapViewModel: mapViewModel)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                mapViewModel.fetchShops()
            }

    
        
    }
    
}


#Preview {
    MapView()
}
