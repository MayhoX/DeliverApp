//
//  DeliverAppApp.swift
//  DeliverApp
//
//  Created by Evan Wong on 13/1/2024.
//

import SwiftUI

@main
struct DeliverAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
