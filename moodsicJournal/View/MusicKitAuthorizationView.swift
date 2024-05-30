//
//  MusicKitAuthorizationView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI
import MusicKit

struct MusicKitAuthorizationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: MusicKitAuthorizationViewModel

      init(musicAuthorizationStatus: MusicAuthorization.Status, isAuthViewShowed: Bool) {
          _viewModel = StateObject(wrappedValue: MusicKitAuthorizationViewModel(musicAuthorizationStatus: musicAuthorizationStatus, isAuthViewShowed: isAuthViewShowed))
      }


    var body: some View {
        VStack {
            Image("moodsic-journal")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text("Start your reinvented personal journaling experience")
                .font(.title)
                .padding(.bottom, 5)
                .foregroundStyle(Color.mainBlue)
            Text("with Moodsic Journal by pressing this button")
                .font(.title)
                .padding(.bottom, 20)
                .foregroundStyle(Color.mainBlue)

            Text("Click Start to allow Moodsic Journal to Access your Apple Music Account")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 50)
                .foregroundStyle(Color.mainOrange)

            if viewModel.musicAuthorizationStatus == .notDetermined || viewModel.musicAuthorizationStatus == .denied {
                Button(action: {viewModel.askForAuthorization()}, label: {
                    Text("Start")
                        .font(.system(size: 20))
                })
                .padding(.horizontal, 50)
                .padding(.vertical, 15)
                .background(.mainBlue)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(radius: 5)
            } else {
                Button(action: {dismiss()}, label: {
                    Text("Continue")
                        .font(.system(size: 20))
                })
                .padding(.horizontal, 50)
                .padding(.vertical, 15)
                .background(.mainBlue)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(radius: 5)
            }

        }
    }
}

#Preview {
    MusicKitAuthorizationView(musicAuthorizationStatus: .notDetermined, isAuthViewShowed: true)
}
