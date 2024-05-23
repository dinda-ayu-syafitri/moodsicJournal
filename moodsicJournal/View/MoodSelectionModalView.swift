//
//  MoodSelectionModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct MoodSelectionModalView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("How are you feeling today?")
            HStack (alignment: .center) {
                Button(action: {}, label: {
                    VStack {
                        Image("dummy-excited")
                            .resizable()
                            .scaledToFit()
                        Text("Excited")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {}, label: {
                    VStack {
                        Image("dummy-happy")
                            .resizable()
                            .scaledToFit()
                        Text("Happy")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {}, label: {
                    VStack {
                        Image("dummy-neutral")
                            .resizable()
                            .scaledToFit()
                        Text("Neutral")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {}, label: {
                    VStack {
                        Image("dummy-sad")
                            .resizable()
                            .scaledToFit()
                        Text("Sad")
                    }

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {}, label: {
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

#Preview {
    MoodSelectionModalView()
}
