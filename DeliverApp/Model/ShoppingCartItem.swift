//
//  ShoppingCartItem.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import Foundation

struct ShoppingCartItem: Identifiable, Codable{
    let id: String
    let sitem: SItem
    var quantity : Int
}
