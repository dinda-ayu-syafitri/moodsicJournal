//
//  JournalViewModel.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 25/05/24.
//

import SwiftUI
import MusicKit
import CoreData

class JournalViewModel: ObservableObject {
    @Published var id: UUID?
    @Published var data: Data?
    @Published var title: String?
    @Published var objectId: NSManagedObjectID?
    @Published var mood: String?
    @Published var songId: String?
    @Published var songs = [Song]()

    private let musicPlayerManager = MusicPlayerManager.shared

    func fetchSongs() async {
        guard let songId = songId else { return }
        if !musicPlayerManager.isPlaying || musicPlayerManager.currentSongId != songId {
            do {
                let searchRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID(rawValue: songId))
                let searchResponse = try await searchRequest.response()
                guard let songPlayed = searchResponse.items.first else { return }
                await musicPlayerManager.play(song: songPlayed)
            } catch {
                print("Error fetching songs: \(error)")
            }
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


