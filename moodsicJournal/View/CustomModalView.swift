//
//  CustomModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI
import MusicKit

struct CustomModalView: View {
    @Environment (\.managedObjectContext) var viewContext
    @Environment (\.dismiss) var dismiss

    @State private var journalTitle = ""
    @State private var mood = ""
    @State private var isSaved = false
    @State private var addTitleDone = false
    @State private var moodSelected = false
    @State var songs = [SongItem]()
    @State var selectedSongId = ""
    @State var playlistId = ""

    var body: some View {
        NavigationStack{
            if !addTitleDone  {
                AddTitleModalView(journalTitle: $journalTitle, addTitleDone: $addTitleDone)
            } else if !moodSelected{
                VStack {
                    MoodSelectionModalView(selectedMood: $mood, playlistId: $playlistId)
                    Button(action: {moodSelected = true}, label: {
                        Text("Save")
                    })
                }
            } else {
                VStack {
                    MusicRecommendationModalView(songs: $songs, selectedSongId: $selectedSongId)
                    Button(action: {newJournal()}, label: {
                        Text("Save")
                    })
                }
                .onAppear {
                    Task {
                        await getSongs()
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

            do {
                try viewContext.save()
                dismiss()
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
            print(playlistResponse)
            if let playlist = playlistResponse.items.first {
                if let tracksCollection = playlist.tracks {
                    let tracksArray = Array(tracksCollection)

                    let shuffledTracks = tracksArray.shuffled()

                    let randomTracks = shuffledTracks.prefix(3)
                    print(randomTracks)

                    let fetchedSongs = randomTracks.compactMap { track in
                        SongItem(id: track.id.rawValue, title: track.title, artist: track.artistName, imageURL: track.artwork?.url(width: 100, height: 100))
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

#Preview {
    CustomModalView()
}
