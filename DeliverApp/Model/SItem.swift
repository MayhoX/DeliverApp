//
//  SItem.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import Foundation
import PhotosUI


struct SItem: Identifiable, Codable{
    let id: String
    let name : String
    let description : String
    let price : String
    let image : Data
}


