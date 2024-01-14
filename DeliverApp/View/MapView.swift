//
//  MapView.swift
//  DeliverApp
//
//  Created by Evan Wong on 14/1/2024.
//

import SwiftUI
import GoogleMaps




struct MapView: View {
    var body: some View {
        Map()
            .edgesIgnoringSafeArea(.top)
    }
}


struct Map: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 22.3193, longitude: 114.1694, zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}

#Preview {
    MapView()
}
