//
//  ShoppingCart.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import Foundation

struct ShoppingCart: Codable {
    var items: [ShoppingCartItem] = []
    
    var total: String {
        let totalPrice = items.reduce(0) { $0 + (Int($1.sitem.price) ?? 0) * $1.quantity }
        return "$\(totalPrice)"
    }
}


