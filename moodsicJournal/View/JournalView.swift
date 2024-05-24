//
//  JournalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI
import CoreData
import MusicKit

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    @State var objectId:NSManagedObjectID?
    @State var mood:String?
    @State var SongId:String?

    @State var isMoodSelected:Bool
    private let player = ApplicationMusicPlayer.shared
    @State var songs = [Song]()


    var body: some View {
        GeometryReader {
            geometry in
            NavigationStack {
                ZStack {
                   if isMoodSelected {
                        VStack(alignment: .leading) {
                            HStack {
                                HStack {
                                    Button(action: {dismiss()}, label: {
                                        Image(systemName: "chevron.left")
                                    })
                                    .buttonStyle(PlainButtonStyle())

                                    Text(title ?? "Untitled")
                                    Text(mood ?? "No Mood")
                                    Text(SongId ?? "No Selected Song")

                                    HStack {
                                    Text("Music")
                                    }
                                }
                                Spacer()


                                Menu {
                                    Button("Delete Journal", action: {deleteJournal()})
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                }

                            }
                            .padding(.horizontal, geometry.size.width * 0.05)
                            .padding(.vertical, geometry.size.height * 0.02)

                            JournalCanvasView(data: data ?? Data(), id: id ?? UUID())
                                .environment(\.managedObjectContext, viewContext)
                                                        //                    .navigationTitle(title ?? "Untitled")
                        }

                   } else {
//                       Rectangle()
//                           .frame(width: geometry.size.width, height: geometry.size.height)
//                           .ignoresSafeArea()
//                           .opacity(0.5)
//                           .overlay {
//                               RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/) 
//                                   .fill(.white)
//                                   .overlay
//                               {
//                                   VStack {
//                                       MoodSelectionModalView()
//                                           .clipShape(.rect(cornerRadius: 25))
//                                           .padding(.horizontal, 50)
//                                           .padding(.bottom, 20)
//                                       Button(action: {isMoodSelected.toggle()}, label: {
//                                           Text("Next")
//                                       })
//                                   }
//
//                               }
//                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.35)
//
//                           }
                   }


                }
//                .onAppear {
//                    Task {
//                        await getSongs()
//                    }
//                }
            }
        }
    }

    private func deleteJournal() {
        guard let objectId = objectId else {
            print("No object ID available to delete")
            return
        }

        do {
            let object = try viewContext.existingObject(with: objectId)
            viewContext.delete(object)

            // Save the context to persist the deletion
            try viewContext.save()
            dismiss()
            print("Object deleted successfully")
        } catch {
            print("Failed to delete object with ID \(objectId): \(error)")
        }
    }

    private func getSongs() async {
           do {
               var searchRequest = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: "1440713319")
//               searchRequest.limit = 3
               let searchResponse = try await searchRequest.response()

               guard let songPlayed = searchResponse.items.first else { return }


               await play(song: songPlayed)
//               // Map the search results to your SongItem model
//                          let fetchedSongs = searchResponse.songs.compactMap { song in
//                              SongItem(id: song.id.rawValue, title: song.title, artist: song.artistName, imageURL: song.artwork?.url(width: 100, height: 100))
//                          }
//
//                          // Update the state on the main thread
//                          DispatchQueue.main.async {
//                              self.songs = fetchedSongs
//                          }
               print("This is the fetched song by ID: \(searchResponse)")
           } catch {
               print("Error fetching songs: \(error)")
           }
       }

    func play(song: Song) async {
      let player = ApplicationMusicPlayer.shared
      player.queue = [song]
        do {try await player.prepareToPlay()}
        catch {
            print(error)
        }
        do {
            try await player.play()
            print("should be played")

        }
        catch {
            print(error)

        }
    }
}

#Preview {
    JournalView(id: UUID(), data: Data(), isMoodSelected: false)
}
