//
//  CustomModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import MusicKit
import SwiftUI

struct CustomModalView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var journalTitle = ""
    @State private var mood = ""
    @State private var isSaved = false
    @State private var addTitleDone = false
    @State private var moodSelected = false
    @State var songs = [SongItem]()
    @State var selectedSongId = ""
    @State var playlistId = ""

    @Binding var isAddJournalOpen: Bool

    var body: some View {
        GeometryReader {
            _ in

            NavigationStack {
                if !addTitleDone {
                    AddTitleModalView(journalTitle: $journalTitle)
//                        .frame(width: .infinity, height: .infinity, alignment: .center)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.horizontal, 50)

                } else if !moodSelected {
                    VStack {
                        Button(action: { addTitleDone.toggle() }, label: {
                            Image(systemName: "arrow.left")

                        })
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.gray)
                        .padding()
                        VStack(alignment: .center, spacing: 20) {
//                            MoodSelectionModalView(selectedMood: $mood, playlistId: $playlistId)
                            Button(action: { moodSelected = true }, label: {
                                Text("Next")
                                    .font(.system(size: 20))
                            })
                            .padding(.horizontal, 50)
                            .padding(.vertical, 15)
                            .background(.mainBlue)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .shadow(radius: 5)
                        }
//                        .frame(width: .infinity, height: .infinity, alignment: .center)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)
                    }

                } else {
                    VStack {
                        Button(action: { moodSelected.toggle() }, label: {
                            Image(systemName: "arrow.left")
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.gray)
                        .buttonStyle(PlainButtonStyle())
                        .padding()

                        VStack(alignment: .center, spacing: 20) {
                            MusicRecommendationModalView(songs: $songs, selectedSongId: $selectedSongId)
                            Button(action: { newJournal() }, label: {
                                Text("Start Journaling !")
                                    .font(.system(size: 20))
                            })
                            .padding(.horizontal, 50)
                            .padding(.vertical, 15)
                            .background(.mainBlue)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .shadow(radius: 5)
                        }
//                        .frame(width: .infinity, height: .infinity, alignment: .center)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .onAppear {
                            Task {
                                await getSongs()
                            }
                        }
                    }
                }
            }
        }
    }

    private func newJournal() {
        withAnimation {
            let newItem = Journal(context: viewContext)
            newItem.title = journalTitle
            newItem.mood = mood
            newItem.id = UUID()
            newItem.songId = selectedSongId
            newItem.createdDate = Date()

            do {
                try viewContext.save()
                dismiss()
                isAddJournalOpen = false
                isSaved = true
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func getSongs() async {
        do {
            var playlistRequest = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: MusicItemID(rawValue: playlistId))
            playlistRequest.properties = [.tracks]

            let playlistResponse = try await playlistRequest.response()

            if let playlist = playlistResponse.items.first {
                if let tracksCollection = playlist.tracks {
                    let tracksArray = Array(tracksCollection)

                    let shuffledTracks = tracksArray.shuffled()

                    let randomTracks = shuffledTracks.prefix(3)

                    let fetchedSongs = randomTracks.compactMap { track in
                        SongItem(id: track.id.rawValue, title: track.title, artist: track.artistName, imageURL: track.artwork)
                    }

                    DispatchQueue.main.async {
                        self.songs = fetchedSongs
                    }
                } else {
                    print("No tracks found in the playlist.")
                }
            } else {
                print("Couldn't find playlist.")
            }
        } catch {
            print("Error fetching songs: \(error)")
        }
    }
}

// #Preview {
//    CustomModalView()
// }
