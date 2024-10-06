//
//  JournalInitViewModel.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 06/10/24.
//

import Foundation
import MusicKit

class JournalInitViewModel: ObservableObject {
    @Published var playlistID: String = ""
    @Published var title: String = ""
    @Published var songs: [SongItem] = []
    @Published var selectedSongID: String = ""

    func createJournal() {
        print(playlistID)
        print(title)
    }

    func fetchSongsFromPlaylist() async {
            do {
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
