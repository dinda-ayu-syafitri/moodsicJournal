//
//  MusicRecommendationModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import MusicKit
import SwiftUI

struct MusicRecommendationModalView: View {
    @EnvironmentObject var journalInitVM: JournalInitViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
//    @Binding var songs: [SongItem]
//
//    @State var selectedSongId: String
    @Binding var currentView: ModalView

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text("Some music recommendation for your today’s Soundtrack")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.mainBlue)
                .multilineTextAlignment(.center)

            HStack(alignment: .top) {
                ForEach(journalInitVM.songs, id: \.self) { song in
                    Button(action: {
                        journalInitVM.selectedSongID = song.id
                    }, label: {
                        VStack(spacing: 16) {
                            ArtworkImage(song.imageURL!, width: 80)
                                .cornerRadius(10)
                                .overlay(content: {
                                    if journalInitVM.selectedSongID == song.id {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.mainBlue, lineWidth: 5)
                                            .frame(width: 80, height: 80)
                                            .overlay(content: {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                            })
                                    }

                                })
                            VStack(spacing: 8) {
                                Text(song.title)
                                Text(song.artist)
                            }
                        }
                        .padding()
                        .foregroundStyle(Color.mainBlue)
                        .cornerRadius(10)
                    })
                }
            }
            Button(action: {
                journalInitVM.createJournal(viewContext: viewContext, dismiss: { dismiss() })

            }) {
                Text("Start Journaling")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(String(describing: journalInitVM.selectedSongID).isEmpty ? Color.gray : Color.mainBlue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
            .disabled(journalInitVM.selectedSongID.isEmpty)
            Spacer()
        }
        .padding(32)
        .onAppear {
            Task {
                await journalInitVM.fetchSongsFromPlaylist()
            }
        }
    }
}

#Preview {
    MusicRecommendationModalView(currentView: .constant(.musicSelection))
        .environmentObject(JournalInitViewModel())
}
