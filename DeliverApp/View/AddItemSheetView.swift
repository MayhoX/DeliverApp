//
//  AddItemSheetView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI
import PhotosUI

struct AddItemSheetView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @Binding var isSheetPresented: Bool
    @Binding var shopID: String
    @State var data: Data?
    @State var selectedItem: [PhotosPickerItem] = []
    @StateObject var sItemViewModel = SItemViewModel()
    
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
            
            TextField("Description", text: $description)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.label), lineWidth: 3)
                )
                .cornerRadius(10.0)
                .shadow(radius: 1)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            TextField("Price", text: $price)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.label), lineWidth: 3)
                )
                .keyboardType(.decimalPad)
                .cornerRadius(10.0)
                .shadow(radius: 1)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            Button(action: {
                Task {
                    
                    try await sItemViewModel.AddSItem(name: name, description: description, price: price, image: data!, shopID: shopID)
                    isSheetPresented = false
                }
                    
            }) {
                Text("Add Item")
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


extension AddItemSheetView: AuthProtocol {
    var formIsValid: Bool {
        guard let validPrice = Double(price), validPrice >= 0.0 else {
            return false
        }
        return !name.isEmpty &&
        !description.isEmpty &&
        !price.isEmpty &&
        data != nil
    }
}
