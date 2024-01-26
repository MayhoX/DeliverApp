//
//  ShopViewModel.swift
//  DeliverApp
//
//  Created by Evan Wong on 21/1/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class ShopViewModel: ObservableObject {
    @Published var shop: Shop?
    @Published var shops: [Shop] = []
    
    func fetchShops() async {
        do {
            let querySnapshot = try await Firestore.firestore().collection("shops").getDocuments()
            self.shops = try querySnapshot.documents.compactMap {
                try $0.data(as: Shop.self)
            }
        } catch {
            print("ERROR FETCHING SHOPS: \(error)")
        }
    }

    
    func AddShop(name: String, latitude: String, longitude: String, address: String, image: Data) async throws{
        do{
            let shop = Shop(id: UUID().uuidString, name: name, latitude: latitude, longitude: longitude, address: address, image: image)
            let encodedShop = try Firestore.Encoder().encode(shop)
            try await Firestore.firestore().collection("shops").document(shop.id).setData(encodedShop)

        } catch {
            print("ERROR ADD SHOP \(error.localizedDescription)")
        }
    }
    
    
    
    
    
}


    
    





