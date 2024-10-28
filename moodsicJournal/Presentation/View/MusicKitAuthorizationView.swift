//
//  MusicKitAuthorizationView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import MusicKit
import SwiftUI

struct MusicKitAuthorizationView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var musicAuthorizationStatus: MusicAuthorization.Status
    @Binding var isAuthViewShowed: Bool

    var body: some View {
        VStack {
            Image("moodsic-journal")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text("Start your reinvented personal journaling experience")
                .font(.title)
                .padding(.bottom, 5)
                .foregroundStyle(Color(.mainBlue))
            Text("with Moodsic Journal by pressing this button")
                .font(.title)
                .padding(.bottom, 20)
                .foregroundStyle(Color(".mainBlue"))

            Text("Click Start to allow Moodsic Journal to Access your Apple Music Account")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 50)
                .foregroundStyle(Color(.mainOrange))

            if musicAuthorizationStatus == .notDetermined || musicAuthorizationStatus == .denied {
                Button(action: { askForAuthorization() }, label: {
                    Text("Start")
                        .font(.system(size: 20))
                })
                .padding(.horizontal, 50)
                .padding(.vertical, 15)
                .background(Color(.mainBlue))
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(radius: 5)
            } else {
                Button(action: { dismiss() }, label: {
                    Text("Continue")
                        .font(.system(size: 20))
                })
                .padding(.horizontal, 50)
                .padding(.vertical, 15)
                .background(Color(.mainBlue))
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(radius: 5)
            }
        }
    }

    private func askForAuthorization() {
        switch musicAuthorizationStatus {
        case .notDetermined:
            Task {
                let musicAuthorizationStatus = await MusicAuthorization.request()
                update(with: musicAuthorizationStatus)
            }
        default:
            isAuthViewShowed = false
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
                }
            default:
                isAuthViewShowed = true
            }
        }
    }
}

#Preview {
    MusicKitAuthorizationView(musicAuthorizationStatus: .constant(.notDetermined), isAuthViewShowed: .constant(true))
}
