//
//  HomeView.swift
//  DeliverApp
//
//  Created by Evan Wong on 16/1/2024.
//

import SwiftUI
import Firebase


struct HomeView: View {
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        self.isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                AddDeliveryShopView(isSheetPresented: $isSheetPresented)
            }
        }
    }
}

#Preview {
    HomeView()
}
