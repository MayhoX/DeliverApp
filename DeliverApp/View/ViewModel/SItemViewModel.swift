//
//  SItemViewModel.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class SItemViewModel: ObservableObject{
    @Published var sItem: SItem?
    @Published var sItems: [SItem] = []
    
    func fetchSItems(shopID: String) async {
        do {
            let querySnapshot = try await Firestore.firestore().collection("shops").document(shopID).collection("sitems").getDocuments()
            self.sItems = try querySnapshot.documents.compactMap {
                try $0.data(as: SItem.self)
            }
        } catch {
            print("ERROR FETCHING SHOPS: \(error)")
        }
    }
    
    func AddSItem(name: String, description: String, price: String, image: Data, shopID: String) async throws{
        do{
            let sitem = SItem(id: UUID().uuidString, name: name, description: description, price: price, image: image)
            let encodedShop = try Firestore.Encoder().encode(sitem)
            try await Firestore.firestore().collection("shops").document(shopID).collection("sitems").document(sitem.id).setData(encodedShop)
            
        } catch {
            print("ERROR ADD SHOP \(error.localizedDescription)")
        }
    }
    
}
