//
//  MoodSelectionModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct MoodSelectionModalView: View {
    @Binding var selectedMood: String
    @Binding var playlistId: String

    var body: some View {
        VStack(spacing: 35) {
            Text("How are you feeling today?")
            HStack (alignment: .center, spacing: 15) {
                Button(action: {
                    selectedMood = "Excited"
                    playlistId = "pl.f9733e33c0c64b1fb1b0a7bff787d566"
                }, label: {
                    VStack {
                        Image("dummy-excited")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)
                        Text("Excited")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    selectedMood = "Happy"
                    playlistId = "pl.0d4aee5424c74d29ad15252eeb43d3b1"
                }, label: {
                    VStack {
                        Image("dummy-happy")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)

                        Text("Happy")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    selectedMood = "Neutral"
                    playlistId = "pl.3aaf0879038242d1a5d2dc95986e6ba2"
                }, label: {
                    VStack {
                        Image("dummy-neutral")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)

                        Text("Neutral")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    selectedMood = "Sad"
                    playlistId = "pl.aa6824f258604a76ba475a4649acabf0"
                }, label: {
                    VStack {
                        Image("dummy-sad")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)

                        Text("Sad")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    selectedMood = "Angry"
                    playlistId = "pl.99aab7ddb4034503bef6278112843dba"
                }, label: {
                    VStack {
                        Image("dummy-angry")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)

                        Text("Angry")
                    }

                })
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

//#Preview {
//    MoodSelectionModalView(selectedMood: )
//}
