//
//  JournalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import CoreData
import MusicKit
import SwiftUI

struct JournalView: View {
    @ObservedObject var viewModel: JournalViewModel
    @ObservedObject var dashboardVM: DashboardViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State var songPlayed: Song?

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 30) {
                            Button(action: { dismiss() }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 32))
                            }
                            .buttonStyle(PlainButtonStyle())

                            Text(viewModel.title ?? "Untitled")
                                .font(.system(size: 24))
                                .fontWeight(.bold)

                            Spacer()

                            if let mood = viewModel.mood?.lowercased() {
                                Image("dummy-\(mood)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 70)
                            }
                            HStack {
                                if let artwork = viewModel.songData?.artwork {
                                    ArtworkImage(artwork, width: 50)
                                        .cornerRadius(8)
                                        .clipShape(Circle())
                                }

                                VStack {
                                    Text(songPlayed?.title ?? "Untitled")
                                        .font(.system(size: 12))
                                        .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(viewModel.songData?.artistName ?? "No Artist")
                                        .font(.system(size: 12))
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                .padding(.horizontal, 5)
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .frame(maxWidth: geometry.size.width * 0.3)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(radius: 5)

                            Menu {
                                Button("Delete Journal", action: {
                                    viewModel.deleteJournal(in: viewContext)
                                    dismiss()
                                })
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                        }
                        .padding(.horizontal, geometry.size.width * 0.03)
                        .padding(.vertical, geometry.size.height * 0.02)

                        JournalCanvasView(data: viewModel.getData(), id: viewModel.getId())
                            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    }
                }
//                .onReceive(viewModel.$songData) { song in
//                    songPlayed = song
//                }
                .onAppear {
                    Task {
//                        print(await viewModel.songData as Any)
                        songPlayed = await viewModel.fetchSongs()
                        await viewModel.playMusic()

//                        await fetchSongs()
                    }
                }
                .onDisappear {
                    viewModel.stopMusic()
                    Task {
                        await dashboardVM.getAllJournals()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }

//    func fetchSongs() async {
//        guard let songId = viewModel.songId else {
//            print("songId is nil")
//            return
//        }
//        do {
//            let searchRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID(rawValue: songId))
//            let searchResponse = try await searchRequest.response()
//            guard let fetchedSongData = searchResponse.items.first else {
//                print("No song data found")
//                return
//            }
//            self.songPlayed = fetchedSongData
//        } catch {
//            print("Error fetching songs: \(error)")
//            return         }
//    }
}

//
// #Preview {
//    JournalView(viewModel: {
//        {
//            let viewModel = JournalViewModel()
//            viewModel.id = UUID()
//            viewModel.title = "Test Journal"
//            viewModel.mood = "Happy"
//            viewModel.songId = "1719617464"
//            viewModel.songData = nil
//            return viewModel
//        }()
//    }(), songPlayed: nil)
// }
