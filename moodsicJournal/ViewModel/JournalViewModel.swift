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

    init(id: UUID? = nil, data: Data? = nil, title: String? = nil, objectId: NSManagedObjectID? = nil, mood: String? = nil, songId: String? = nil, songs: [Song] = [Song](), songData: Song? = nil, createdDate: Date? = nil) {
        self.id = id
        self.data = data
        self.title = title
        self.objectId = objectId
        self.mood = mood
        self.songId = songId
        self.songs = songs
        self.songData = songData
        self.createdDate = createdDate
    }

    func getData() -> Data {
//        return Data()
        return data ?? Data()
    }

    func getId() -> UUID {
//        return UUID()
        return id ?? UUID()
    }

    private let musicPlayerManager = MusicPlayerManager.shared

    func fetchSongs() async -> Song? {
        if songData != nil {
            return nil
        }

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

    func playMusic() async {
        if songData != nil {
            await musicPlayerManager.play(song: songData!)
        }
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


