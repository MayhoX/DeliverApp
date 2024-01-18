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
//    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map()
            .edgesIgnoringSafeArea(.top)
        
        
        
    }
    
}

struct Map: UIViewRepresentable {
    
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?

    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.map(withFrame: .zero, camera: GMSCameraPosition.camera(withLatitude: 22.3193, longitude: 114.1694, zoom: 15.0))
        
        locationManager.delegate = context.coordinator
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let userLocation = userLocation {
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.latitude, longitude: userLocation.longitude, zoom: 15.0)
            uiView.animate(to: camera)
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: Map
        
        init(_ parent: Map) {
            self.parent = parent
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last?.coordinate {
                parent.userLocation = location
            }
        }
    }
}




#Preview {
    MapView()
}
