//
//  MoodSelectionModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct MoodSelectionModalView: View {
    @State var selectedMood: String = ""
    @State var playlistId: String = ""

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button(action: {  }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                })
                Spacer()
            }
            Text("How are you feeling today?")
                .font(.title)
                .fontWeight(.semibold)
            HStack(alignment: .center, spacing: 15) {
                Button(action: {
                    selectedMood = "Excited"
                    playlistId = "pl.f9733e33c0c64b1fb1b0a7bff787d566"
                }, label: {
                    VStack {
                        Image("dummy-excited")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)
                            .overlay(content: {
                                if selectedMood == "Excited" {
                                    Circle()
                                        .fill(.black.opacity(0.2))
                                        .padding(.bottom, 10)
                                        .overlay(content: {
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                        })
                                }

                            })
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
                            .overlay(content: {
                                if selectedMood == "Happy" {
                                    Circle()
                                        .fill(.black.opacity(0.2))
                                        .padding(.bottom, 10)
                                        .overlay(content: {
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                        })
                                }

                            })
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
                            .overlay(content: {
                                if selectedMood == "Neutral" {
                                    Circle()
                                        .fill(.black.opacity(0.2))
                                        .padding(.bottom, 10)
                                        .overlay(content: {
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                        })
                                }

                            })
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
                            .overlay(content: {
                                if selectedMood == "Sad" {
                                    Circle()
                                        .fill(.black.opacity(0.2))
                                        .padding(.bottom, 10)
                                        .overlay(content: {
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                        })
                                }

                            })
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
                            .overlay(content: {
                                if selectedMood == "Angry" {
                                    Circle()
                                        .fill(.black.opacity(0.2))
                                        .padding(.bottom, 10)
                                        .overlay(content: {
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                        })
                                }

                            })
                        Text("Angry")
                    }

                })
                .buttonStyle(PlainButtonStyle())
            }
            Button(action: {
            }) {
                Text("Next")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(selectedMood.isEmpty ? Color.gray : Color.mainBlue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
            .disabled(selectedMood.isEmpty)
            Spacer()
        }
    }
}

#Preview {
    MoodSelectionModalView()
//    MoodSelectionModalView(selectedMood: .constant("Sad"), playlistId: .constant("..."))
}
