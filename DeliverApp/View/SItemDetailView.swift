//
//  SItemDetailView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI

struct SItemDetailView: View {
    
    @State var isSheetPresented: Bool = false
    @EnvironmentObject var userViewModel: AuthViewModel
    @StateObject var sitemViewModel = SItemViewModel()
    
    var sitem: SItem
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

