//
//  MoodSelectionModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct MoodSelectionModalView: View {
    @Binding var selectedMood: String

    var body: some View {
        VStack(spacing: 50) {
            Text("How are you feeling today?")
            HStack (alignment: .center) {
                Button(action: {selectedMood = "Excited"}, label: {
                    VStack {
                        Image("dummy-excited")
                            .resizable()
                            .scaledToFit()
                        Text("Excited")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {selectedMood = "Happy"}, label: {
                    VStack {
                        Image("dummy-happy")
                            .resizable()
                            .scaledToFit()
                        Text("Happy")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {selectedMood = "Neutral"}, label: {
                    VStack {
                        Image("dummy-neutral")
                            .resizable()
                            .scaledToFit()
                        Text("Neutral")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {selectedMood = "Sad"}, label: {
                    VStack {
                        Image("dummy-sad")
                            .resizable()
                            .scaledToFit()
                        Text("Sad")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {selectedMood = "Angry"}, label: {
                    VStack {
                        Image("dummy-angry")
                            .resizable()
                            .scaledToFit()
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
