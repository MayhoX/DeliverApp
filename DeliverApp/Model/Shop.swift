//
//  Shop.swift
//  DeliverApp
//
//  Created by Evan Wong on 16/1/2024.
//

import Foundation
import PhotosUI


struct Shop: Identifiable, Codable{
    let id: String
    let name : String
    let latitude : String
    let longitude : String
    let address : String
    let image : Data
}




