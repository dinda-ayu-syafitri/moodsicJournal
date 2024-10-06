//
//  MoodSelectionModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct MoodSelectionModalView: View {
    @EnvironmentObject var journalInitVM: JournalInitViewModel
//    @State var selectedMood: String = ""
//    @Binding var playlistId: String
    @Binding var currentView: ModalView

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button(action: {}, label: {
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
                .foregroundStyle(Color.mainBlue)

            HStack(alignment: .center, spacing: 32) {
                Button(action: {
                    journalInitVM.mood = .excited
                    journalInitVM.playlistID = "pl.f9733e33c0c64b1fb1b0a7bff787d566"
                }, label: {
                    VStack(spacing: 8) {
                        Image("dummy-excited")
                            .resizable()
                            .scaledToFit()
                            .overlay(content: {
                                if journalInitVM.mood == .excited {
                                    Circle()
                                        .stroke(.mainBlue, lineWidth: 7)
                                        .overlay(content: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        })
                                }

                            })
                        Text("Excited")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainBlue)

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    journalInitVM.mood = .happy
                    journalInitVM.playlistID = "pl.0d4aee5424c74d29ad15252eeb43d3b1"
                }, label: {
                    VStack(spacing: 8) {
                        Image("dummy-happy")
                            .resizable()
                            .scaledToFit()
                            .overlay(content: {
                                if journalInitVM.mood == .happy {
                                    Circle()
                                        .stroke(.mainBlue, lineWidth: 7)
                                        .overlay(content: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        })
                                }

                            })
                        Text("Happy")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainBlue)

                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    journalInitVM.mood = .neutral
                    journalInitVM.playlistID = "pl.3aaf0879038242d1a5d2dc95986e6ba2"
                }, label: {
                    VStack(spacing: 8) {
                        Image("dummy-neutral")
                            .resizable()
                            .scaledToFit()
                            .overlay(content: {
                                if journalInitVM.mood == .neutral {
                                    Circle()
                                        .stroke(.mainBlue, lineWidth: 7)
                                        .overlay(content: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        })
                                }

                            })
                        Text("Neutral")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainBlue)
                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    journalInitVM.mood = .sad
                    journalInitVM.playlistID = "pl.aa6824f258604a76ba475a4649acabf0"
                }, label: {
                    VStack(spacing: 8) {
                        Image("dummy-sad")
                            .resizable()
                            .scaledToFit()
                            .overlay(content: {
                                if journalInitVM.mood == .sad {
                                    Circle()
                                        .stroke(.mainBlue, lineWidth: 7)
                                        .overlay(content: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                        })
                                }

                            })
                        Text("Sad")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainBlue)
                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    journalInitVM.mood = .angry
                    journalInitVM.playlistID = "pl.99aab7ddb4034503bef6278112843dba"
                }, label: {
                    VStack(spacing: 8) {
                        Image("dummy-angry")
                            .resizable()
                            .scaledToFit()
                            .overlay(content: {
                                if journalInitVM.mood == .angry {
                                    Circle()
                                        .stroke(.mainBlue, lineWidth: 7)
                                        .overlay(content: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30)

                                        })
                                }

                            })
                        Text("Angry")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainBlue)

                })
                .buttonStyle(PlainButtonStyle())
            }
            Button(action: {
                currentView = .musicSelection
            }) {
                Text("Next")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(journalInitVM.mood == .none ? Color.gray : Color.mainBlue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
            .disabled(journalInitVM.mood == .none)
            Spacer()
        }
        .padding(32)
    }
}

#Preview {
    MoodSelectionModalView(currentView: .constant(.moodSelection))
        .environmentObject(JournalInitViewModel())
//    MoodSelectionModalView(selectedMood: .constant("Sad"), playlistId: .constant("..."))
}
