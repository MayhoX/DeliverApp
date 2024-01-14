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
    
    init() {
        GMSServices.provideAPIKey("AIzaSyD_zf_tp4udYWjf3DfanaTMAEu6rmNYphA")
    }
    
    var body: some View {
        Group {
            if viewModel.userSession != nil{
                TabView {
                    MapView()
                        .tabItem {
                            Label("Map", systemImage: "map")
                        }
                    
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
                
            } else {
                LoginView()
            }
        }
    }
}




#Preview {
    ContentView()
}
