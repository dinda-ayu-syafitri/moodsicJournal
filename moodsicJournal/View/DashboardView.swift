//
//  DashboardView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI
import CoreData
import MusicKit

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Journal.entity(), sortDescriptors: [])
    private var journals: FetchedResults<Journal>

    @State private var isAddJournalOpen = false

    @State  var musicAuthorizationStatus: MusicAuthorization.Status
    @State  var isAuthViewShowed: Bool

    private let player = ApplicationMusicPlayer.shared


    var body: some View {
        GeometryReader {
            geometry in
            NavigationSplitView(
                sidebar: {},
                detail: {
                    VStack(alignment: .leading) {
                        Text("Dashboard")
                        Button(action: {
                            isAddJournalOpen.toggle()
                        }, label: {
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(.white)
                                .frame(width: 200, height: 200)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .overlay {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(Color.blue)
                                        .frame(maxWidth: 70)
                                }
                        })
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $isAddJournalOpen, content: {
                            CustomModalView().environment(\.managedObjectContext, viewContext)
                        })
                        .padding(.bottom, 20)

                        List {
                            ForEach(journals){journal in
                                NavigationLink(destination: JournalView(id: journal.id, data: journal.canvasData, title: journal.title, objectId: journal.objectID, mood: journal.mood, SongId: journal.songId, isMoodSelected: true), label: {
                                    Text(journal.title ?? "Untitled")
                                })

                            }
                        }
                        .onAppear {
                            Task {
                                player.stop()
                                print("song should be stopped")
                            }
                    }
                    .sheet(isPresented: $isAuthViewShowed, content: {
                        MusicKitAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus, isAuthViewShowed: $isAuthViewShowed)
                    })
                    .padding(.horizontal, geometry.size.width * 0.05)
                }
                })
        }



    }
}

//#Preview {
//    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

