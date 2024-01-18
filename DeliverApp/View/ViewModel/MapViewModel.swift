////
////  MapViewModel.swift
////  DeliverApp
////
////  Created by Evan Wong on 15/1/2024.
////
//import Foundation
//import CoreLocation
//
//class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var userLocation: CLLocationCoordinate2D?
//    private var locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        setupLocationManager()
//    }
//    
//    
//
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last?.coordinate {
//            userLocation = location
//        }
//    }
//}
