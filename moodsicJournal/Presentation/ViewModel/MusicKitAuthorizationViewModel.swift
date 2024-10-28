//
//  MusicKitAuthorizationViewModel.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/05/24.
//

import Foundation
import MusicKit
import SwiftUI

class MusicKitAuthorizationViewModel: ObservableObject {
    @Published var musicAuthorizationStatus: MusicAuthorization.Status
    @Published var isAuthViewShowed: Bool

    init(musicAuthorizationStatus: MusicAuthorization.Status = .notDetermined, isAuthViewShowed: Bool = true) {
        self.musicAuthorizationStatus = musicAuthorizationStatus
        self.isAuthViewShowed = isAuthViewShowed
    }

    func askForAuthorization() {
        switch musicAuthorizationStatus {
        case .notDetermined:
            Task {
                let musicAuthorizationStatus = await MusicAuthorization.request()
                await update(with: musicAuthorizationStatus)
            }
        default:
            isAuthViewShowed = false
        }
    }

    @MainActor
    func update(with musicAuthorizationStatus: MusicAuthorization.Status) {
        withAnimation {
            self.musicAuthorizationStatus = musicAuthorizationStatus
            switch musicAuthorizationStatus {
            case .authorized:
                Task {
                    isAuthViewShowed = false
                }
            default:
                isAuthViewShowed = true
            }
        }
    }
}
