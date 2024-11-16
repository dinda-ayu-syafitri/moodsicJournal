//
//  moodsicJournalApp.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import MusicKit
import SwiftUI

@main
struct moodsicJournalApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        DependencyInjection.shared.initializer(context: persistenceController.container.viewContext)
    }

    var body: some Scene {
        WindowGroup {
            RouterView {
                DashboardView(musicAuthorizationStatus: MusicAuthorization.currentStatus,
                              isAuthViewShowed: MusicAuthorization.currentStatus != .authorized)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
