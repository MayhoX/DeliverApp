//
//  MapViewModel.swift
//  DeliverApp
//
//  Created by Evan Wong on 15/1/2024.
//
import Foundation
import CoreLocation
import GoogleMaps
import FirebaseFirestore
import FirebaseFirestoreSwift

class MapViewModel: ObservableObject {
       
    @Published var shops: [Shop] = []
    @Published var selectedShop: Shop?
    private var db = Firestore.firestore()

    func fetchShops() {
            db.collection("shops")
                .addSnapshotListener { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting shops: \(error.localizedDescription)")
                        return
                    }

                    guard let documents = querySnapshot?.documents else {
                        print("No shops available")
                        return
                    }

                    self.shops = documents.compactMap { queryDocumentSnapshot in
                        try? queryDocumentSnapshot.data(as: Shop.self)
                    }
                }
        }
    
    
    
    func mapAddShop(mapView: GMSMapView) {
        for shop in shops {
            if let latitude = Double(shop.latitude), let longitude = Double(shop.longitude) {
                let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let marker = GMSMarker(position: position)
                marker.title = shop.name
                marker.map = mapView
            }
        }
    }
    
    
    
}
