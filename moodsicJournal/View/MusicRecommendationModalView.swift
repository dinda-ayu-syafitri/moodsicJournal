//
//  MusicRecommendationModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI
import MusicKit

struct MusicRecommendationModalView: View {
    @Binding var songs: [SongItem]

    @Binding var selectedSongId:String

    var body: some View {
        VStack {
            Text("Some music recommendation for your today’s Soundtrack")

            HStack {
                ForEach(songs) { song in
                    Button(action: {selectedSongId = song.id}, label: {
                        VStack {
                            Text(song.title)
                            Text(song.artist)
                        }
                    })
                }
            }

        }
        
    }
}

//#Preview {
//    MusicRecommendationModalView()
//}
