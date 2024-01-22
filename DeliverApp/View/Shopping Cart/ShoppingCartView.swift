//
//  ShoppingCartView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(shoppingCartViewModel.cart.items) { cartItem in
                        HStack {
                            if let uiImage = UIImage(data: cartItem.sitem.image) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 80)
                            }
                            
                            Text(cartItem.sitem.name)
                            Spacer()
                            Text("Quantity: \(cartItem.quantity)")
                        }
                    }
                    .onDelete(perform: deleteCartItem)
                }
                .listStyle(PlainListStyle())
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("Total: \(shoppingCartViewModel.cart.total)")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                
                Button(action: {
                    
                }) {
                    Text("Checkout")
                }
            }
            .navigationTitle("Shopping Cart")
            .navigationBarItems(
                trailing: Button(action: {
                   
                    shoppingCartViewModel.clearAll()
                }) {
                    Text("Clear All")
                        .foregroundColor(.red)
                }
            )
        }
    }
        
        func deleteCartItem(at offsets: IndexSet) {
            for index in offsets {
                let cartItem = shoppingCartViewModel.cart.items[index]
                shoppingCartViewModel.removeFromCart(cartItem: cartItem)
            }
        }
}


#Preview {
    ShoppingCartView()
}
