//
//  Router.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 06/10/24.
//

import MusicKit
import SwiftUI

class Router: ObservableObject {
    static let shared = Router()
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case Dashboard(musicAuthorizationStatus: MusicAuthorization.Status, isAuthViewShowed: Bool)
//        case JournalInitTitle(JournalTitle: Binding<String>)
//        case JournalInitMood(currentView: ModalView)
//        case JournalInitMusic(currentView: ModalView)
    }

    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = .init()

    //     Builds the views
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .Dashboard(let musicAuthorizationStatus, let isAuthViewShowed):
            DashboardView(musicAuthorizationStatus: musicAuthorizationStatus, isAuthViewShowed: isAuthViewShowed)
//        case .JournalInitTitle(let journalTitle):
//            AddTitleModalView(journalTitle: journalTitle)
//        case .JournalInitMood(let currentView):
//            MoodSelectionModalView(currentView: currentView)
//        case .JournalInitMusic(let currentView):
//            MusicRecommendationModalView(currentView: currentView)
        }
    }

    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }

    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }

    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }

    func resetAndNavigateTo(_ appRoute: Route) {
        path = .init() // Reset the navigation stack
        path.append(appRoute)
    }
}
