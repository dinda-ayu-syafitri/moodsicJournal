//
//  MusicPlayerManager.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 25/05/24.
//

import SwiftUI
import MusicKit

class MusicPlayerManager: ObservableObject {
    static let shared = MusicPlayerManager()
    private let player = ApplicationMusicPlayer.shared

    @Published var isPlaying = false
    @Published var currentSongId: String?

    private init() {}

    func play(song: Song) async {
        if !isPlaying || currentSongId != song.id.rawValue {
            player.queue = [song]
            do {
                try await player.prepareToPlay()
                try await player.play()
                isPlaying = true
                currentSongId = song.id.rawValue
            } catch {
                print(error)
            }
        }
    }

    func stop() {
        player.stop()
        isPlaying = false
        currentSongId = nil
    }
}


