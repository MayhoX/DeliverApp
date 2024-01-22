//
//  ContentView.swift
//  DeliverApp
//
//  Created by Evan Wong on 13/1/2024.
//

import SwiftUI
import CoreData
import GoogleMaps

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var faceIDModel: FaceIDModel
    @EnvironmentObject var cartViewModel: ShoppingCartViewModel
    init() {
        GMSServices.provideAPIKey("AIzaSyD_zf_tp4udYWjf3DfanaTMAEu6rmNYphA")
    }
    
    
    
    var body: some View {
        if !viewModel.login && !faceIDModel.isAuthenicated {
            LoginView()
        } else {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                ShoppingCartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
        }
    }
}




#Preview {
    ContentView()
}
