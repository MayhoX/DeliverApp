//
//  ShoppingCartViewModel.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import Foundation

class ShoppingCartViewModel: ObservableObject {
    @Published var cart: ShoppingCart = ShoppingCart()
        
    func addToCart(sitem: SItem, quantity: Int) {
        let cartItem = ShoppingCartItem(id: UUID().uuidString, sitem: sitem, quantity: quantity)
        cart.items.append(cartItem)
    }
        
    func removeFromCart(cartItem: ShoppingCartItem) {
        cart.items.removeAll { $0.id == cartItem.id }
    }
        
    func updateQuantity(cartItem: ShoppingCartItem, quantity: Int) {
        guard let index = cart.items.firstIndex(where: { $0.id == cartItem.id }) else {
            return
        }
        cart.items[index].quantity = quantity
    }
    
    func clearAll() {
        cart.items.removeAll()
    }
}
