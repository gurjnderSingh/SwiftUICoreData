//
//  DevoteCoreDataApp.swift
//  DevoteCoreData
//
//  Created by Gurjinder Singh on 11/01/23.
//

import SwiftUI

@main
struct DevoteCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
