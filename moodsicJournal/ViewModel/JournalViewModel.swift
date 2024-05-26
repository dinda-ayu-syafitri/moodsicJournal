//
//  JournalViewModel.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 25/05/24.
//

import SwiftUI
import MusicKit
import CoreData

@MainActor
class JournalViewModel: ObservableObject {
    @Published var id: UUID?
    @Published var data: Data?
    @Published var title: String?
    @Published var objectId: NSManagedObjectID?
    @Published var mood: String?
    @Published var songId: String?
    @Published var songs = [Song]()
    @Published var songData: Song?
    @Published var createdDate: Date?

    private let musicPlayerManager = MusicPlayerManager.shared

    func fetchSongs() async -> Song? {
        guard let songId = songId else {
            print("songId is nil")
            return nil
        }
        do {
            print("Fetching song with ID: \(songId)")
            let searchRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID(rawValue: songId))
            let searchResponse = try await searchRequest.response()
            guard let fetchedSongData = searchResponse.items.first else {
                print("No song data found")
                return nil
            }
            self.songData = fetchedSongData
            print("Song data updated: \(String(describing: self.songData))")
            return fetchedSongData
        } catch {
            print("Error fetching songs: \(error)")
            return nil
        }
    }

    func fetchSongData() async {
        self.songData = await fetchSongs() // Assuming fetchSongs is an async function
        print(songData!)
    }



    func playMusic() async {
        await musicPlayerManager.play(song: await fetchSongs()!)
    }

    func stopMusic() {
        musicPlayerManager.stop()
    }

    func deleteJournal(in context: NSManagedObjectContext) {
        guard let objectId = objectId else {
            print("No object ID available to delete")
            return
        }

        do {
            let object = try context.existingObject(with: objectId)
            context.delete(object)
            try context.save()
            print("Object deleted successfully")
        } catch {
            print("Failed to delete object with ID \(objectId): \(error)")
        }
    }
}


