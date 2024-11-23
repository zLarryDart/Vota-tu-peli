//
//  Vota_tu_peliApp.swift
//  Vota tu peli
//
//  Created by Armando Larios Avila on 22/11/24.
//

import SwiftUI

@main
struct Vota_tu_peliApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
