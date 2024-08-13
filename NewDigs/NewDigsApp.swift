//
//  NewDigsApp.swift
//  NewDigs
//
//  Created by Max Goldberg on 11/4/22.
//

import SwiftUI

@main
struct NewDigsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var locationVM = LocationVM()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
