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

    var body: some View {
        NavigationStack{
            if !addTitleDone  {
                AddTitleModalView(journalTitle: $journalTitle, addTitleDone: $addTitleDone)
            } else if !moodSelected{
                VStack {
                    MoodSelectionModalView(selectedMood: $mood)
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
            var searchRequest = MusicCatalogSearchRequest(term: "Sad", types: [Song.self])
            searchRequest.limit = 3
            let searchResponse = try await searchRequest.response()



            var playlistRequest = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: "pl.aa6824f258604a76ba475a4649acabf0")
            playlistRequest.properties = [.tracks]


            let playlistResponse = try await playlistRequest.response()
            if let playlist = playlistResponse.items.first {
                if let tracksCollection = playlist.tracks {
                    // Convert MusicItemCollection<Track> to an array
                    let tracksArray = Array(tracksCollection)

                    // Shuffle the array
                    let shuffledTracks = tracksArray.shuffled()

                    // Take the first 3 tracks from the shuffled array
                    let randomTracks = shuffledTracks.prefix(3)
                    print(randomTracks)

                    let fetchedSongs = randomTracks.compactMap { track in
                        SongItem(id: track.id.rawValue, title: track.title, artist: track.artistName, imageURL: track.artwork?.url(width: 100, height: 100))
                    }

                    // Update the state on the main thread
                    DispatchQueue.main.async {
                        self.songs = fetchedSongs
                    }
                } else {
                    print("No tracks found in the playlist.")
                }
            } else {
                print("Couldn't find playlist.")
            }


            //            let playlists = searchResponse.playlists


            //             Map the search results to your SongItem model
            //            let fetchedSongs = randomTracks.songs.compactMap { song in
            //                SongItem(id: song.id.rawValue, title: song.title, artist: song.artistName, imageURL: song.artwork?.url(width: 100, height: 100))
            //            }
            //
            //            // Update the state on the main thread
            //            DispatchQueue.main.async {
            //                self.songs = fetchedSongs
            //            }
            //            print(playlistRequest)
            //            print(searchPlaylistResponse)
        } catch {
            print("Error fetching songs: \(error)")
        }
    }
}

#Preview {
    CustomModalView()
}
