//
//  JournalInitViewModel.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 06/10/24.
//

import CoreData
import Foundation
import MusicKit

class JournalInitViewModel: ObservableObject {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) private var dismiss

    @Published var playlistID: String = ""
    @Published var title: String = ""
    @Published var mood: MoodEnum = .none
    @Published var songs: [SongItem] = []
    @Published var selectedSongID: String = ""
    @Published var isLoadingPlaylist: Bool = false

    func createJournal(viewContext: NSManagedObjectContext, dismiss: () -> Void) {
        let newItem = Journal(context: viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.mood = String(describing: mood)
        newItem.songId = selectedSongID
        newItem.createdDate = Date()

        do {
            try viewContext.save()
            dismiss()
            print(newItem)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func fetchSongsFromPlaylist() async {
        do {
            isLoadingPlaylist = true
            var playlistRequest = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: MusicItemID(rawValue: playlistID))
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
                        self.isLoadingPlaylist = false
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
