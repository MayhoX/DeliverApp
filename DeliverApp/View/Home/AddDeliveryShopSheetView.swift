//
//  AddDeliveryShopSheetView.swift
//  DeliverApp
//
//  Created by Evan Wong on 21/1/2024.
//

import SwiftUI
import PhotosUI

struct AddDeliveryShopSheetView: View {
    
    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var address: String = ""
    @Binding var isSheetPresented: Bool
    @StateObject var shopViewModel = ShopViewModel()
    
    @State var data: Data?
    @State var selectedItem: [PhotosPickerItem] = []
    
    var body: some View {
        
        VStack{
            Section {
                PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, selectionBehavior: .default, matching: .images, preferredItemEncoding: .automatic) {
                    if let data = data, let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame( maxHeight: 300)
                    } else {
                        Label("Select a picture", systemImage: "photo.on.rectangle.angled")
                    }
                }.onChange(of: selectedItem) { newValue in
                    guard let item = selectedItem.first else {
                        return
                    }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                self.data = data
                            }
                        case .failure(let failure):
                            print("Error: \(failure.localizedDescription)")
                        }
                    }
                }
            }
            .padding(20)
            
            TextField("Name", text: $name)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.label), lineWidth: 3)
                )
                .cornerRadius(10.0)
                .shadow(radius: 1)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            TextField("Latitude", text: $latitude)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.label), lineWidth: 3)
                )
                .cornerRadius(10.0)
                .shadow(radius: 1)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            TextField("Longitude", text: $longitude)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.label), lineWidth: 3)
                )
                .cornerRadius(10.0)
                .shadow(radius: 1)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            TextField("Address", text: $address)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.label), lineWidth: 3)
                )
                .cornerRadius(10.0)
                .shadow(radius: 1)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            
            Button(action: {
                Task {
                    try await shopViewModel.AddShop(name: name, latitude: latitude, longitude: longitude, address: address, image: data!)
                    isSheetPresented = false
                }
            }) {
                Text("Add Shop")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 52)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                
            }
            
            
        }
    }
}



extension AddDeliveryShopSheetView: AuthProtocol {
    var formIsValid: Bool {
        return !name.isEmpty &&
        !latitude.isEmpty &&
        !longitude.isEmpty &&
        !address.isEmpty &&
        data != nil
    }
}


#Preview {
    AddDeliveryShopSheetView(isSheetPresented: .constant(true))
}
