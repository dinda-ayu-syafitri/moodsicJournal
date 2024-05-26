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
        VStack(alignment: .center) {
            Text("Some music recommendation for your today’s Soundtrack")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)

            HStack(alignment: .top) {
                ForEach($songs, id: \.self) { $song in
                    Button(action: {
                        selectedSongId = song.id
                    }, label: {
                        VStack {
                            ArtworkImage(song.imageURL!, width: 80)
                                .cornerRadius(8)
                            Text(song.title)
                            Text(song.artist)
                        }
                        .padding()
                        .background(selectedSongId == song.id ? Color.gray : Color.clear)
                        .cornerRadius(10)
                    })
                }
            }

        }
    }
}

//#Preview {
//    MusicRecommendationModalView()
//}
