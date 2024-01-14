//
//  ContentView.swift
//  DeliverApp
//
//  Created by Evan Wong on 13/1/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil{
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}




#Preview {
    ContentView()
}
