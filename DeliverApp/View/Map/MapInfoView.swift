//
//  MapInfoView.swift
//  DeliverApp
//
//  Created by Evan Wong on 21/1/2024.
//

import SwiftUI
import GoogleMaps
import CoreLocation

struct MapInfoView: UIViewRepresentable {
    
    @ObservedObject var mapViewModel: MapViewModel
    
    @Binding var isShowingSheet: Bool
//    @State var selectedShop: Shop?
    @Binding var selectedShop: Shop?
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?


      func updateUIView(_ uiView: GMSMapView, context: Context) {
          mapViewModel.mapAddShop(mapView: uiView)
          if let userLocation = userLocation {
              let camera = GMSCameraPosition.camera(withLatitude: userLocation.latitude, longitude: userLocation.longitude, zoom: 15.0)
              uiView.animate(to: camera)
          }
          
      }
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.map(withFrame: .zero, camera: GMSCameraPosition.camera(withLatitude: 22.3193, longitude: 114.1694, zoom: 15.0))
        
        locationManager.delegate = context.coordinator
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CLLocationManagerDelegate, GMSMapViewDelegate {
        var parent: MapInfoView
        
        init(_ parent: MapInfoView) {
            self.parent = parent
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last?.coordinate {
                parent.userLocation = location
            }
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let shop = parent.mapViewModel.shops.first(where: { $0.name == marker.title }) {
                parent.selectedShop = shop
            }
            return false
        }

        
    }
}
