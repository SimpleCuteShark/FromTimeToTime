//
//  FromTimeToTimeApp.swift
//  FromTimeToTime
//
//  Created by Alexandr Romantsov on 24.11.2021.
//

import SwiftUI

@main
struct FromTimeToTimeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
