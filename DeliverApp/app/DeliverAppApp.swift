//
//  DeliverAppApp.swift
//  DeliverApp
//
//  Created by Evan Wong on 13/1/2024.
//

import SwiftUI
import Firebase
@main
struct DeliverAppApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var faceIDModel = FaceIDModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
                .environmentObject(faceIDModel)
                
        }
    }
}
