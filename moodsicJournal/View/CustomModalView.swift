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

            // Map the search results to your SongItem model
            let fetchedSongs = searchResponse.songs.compactMap { song in
                SongItem(id: song.id.rawValue, title: song.title, artist: song.artistName, imageURL: song.artwork?.url(width: 100, height: 100))
            }

            // Update the state on the main thread
            DispatchQueue.main.async {
                self.songs = fetchedSongs
            }
            print(searchResponse)
        } catch {
            print("Error fetching songs: \(error)")
        }
    }
}

#Preview {
    CustomModalView()
}
