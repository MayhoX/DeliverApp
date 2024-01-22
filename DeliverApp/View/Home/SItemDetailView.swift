//
//  SItemDetailView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI

struct SItemDetailView: View {
    
    
    @StateObject var sitemViewModel = SItemViewModel()
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var sitem: SItem
    @State private var count = 1
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(data: sitem.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
            }
            
            Text("Name: \(sitem.name)")
                .font(.title)
            
            Text("Address: \(sitem.description)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Price: $\(sitem.price)")
                .font(.subheadline)
            
            Spacer()
        }

        Divider()
        
 
        HStack {
            Button(action: {
                if count > 1 {
                    count -= 1
                }
            }) {
                Image(systemName: "minus.circle")
            }
            
            Text("\(count)")
            
            Button(action: {
                count += 1
            }) {
                Image(systemName: "plus.circle")
            }
            
            Spacer()
            
            Button(action: {
                shoppingCartViewModel.addToCart(sitem: sitem, quantity: count)
                showAlert = true
            }) {
                Text("Add to Cart")
                    .font(.headline)
                    
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Item Added"),
                message: Text("The item has been added to your cart."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        Divider()
        
        .navigationTitle("Item Detail")
    }
}

