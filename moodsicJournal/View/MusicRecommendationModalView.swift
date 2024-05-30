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
                                .padding(.bottom, 5)
                            Text(song.artist)
                        }
                        .padding()
                        .background(selectedSongId == song.id ? Color.lightBlue : Color.clear)
                        .foregroundStyle(Color.mainBlue)
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
