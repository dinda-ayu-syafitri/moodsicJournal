//
//  MusicKitAuthorizationView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI
import MusicKit

struct MusicKitAuthorizationView: View {
    @Binding var musicAuthorizationStatus: MusicAuthorization.Status
    @Binding var isAuthViewShowed:Bool



    var body: some View {
        Text("Start your Moodsic Journal by this button")
        if musicAuthorizationStatus == .notDetermined || musicAuthorizationStatus == .denied {
            Button(action: {askForAuthorization()}, label: {
                Text("Start")
            })
        } else {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Yakkk udh authorized")
            })
        }

    }

    private func askForAuthorization() {
        print("Testt authorize")

        switch musicAuthorizationStatus {
        case .notDetermined:
            Task {
                let musicAuthorizationStatus = await MusicAuthorization.request()
                await update(with: musicAuthorizationStatus)
            }
        default:
            isAuthViewShowed = false
           print("Gapapaaa")
        }
    }

    @MainActor
    private func update(with musicAuthorizationStatus: MusicAuthorization.Status) {
        withAnimation {
            self.musicAuthorizationStatus = musicAuthorizationStatus
            switch musicAuthorizationStatus {
            case .authorized:
                Task {
                    isAuthViewShowed = false
                    print("Yepp authorized :)")
                }
            default:
                isAuthViewShowed = true
            }
        }
    }
}

//#Preview {
//    MusicKitAuthorizationView()
//}
