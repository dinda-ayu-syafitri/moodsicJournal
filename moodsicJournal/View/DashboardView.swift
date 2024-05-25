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
    @State var musicAuthorizationStatus: MusicAuthorization.Status
    @State var isAuthViewShowed: Bool
    @State private var selectedJournal: Journal?

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(alignment: .leading) {
                                        Text("Dashboard")
                                        Button(action: {
                                            isAddJournalOpen.toggle()
                                        }, label: {
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(.white)
                                                .frame(width: 200, height: 200)
                                                .shadow(radius: 10)
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

                                        VStack {
                                            ForEach(journals) { journal in
                                                NavigationLink(destination: JournalView(viewModel: {
                                                    {
                                                        let viewModel = JournalViewModel()
                                                        viewModel.id = journal.id
                                                        viewModel.data = journal.canvasData
                                                        viewModel.title = journal.title
                                                        viewModel.objectId = journal.objectID
                                                        viewModel.mood = journal.mood
                                                        viewModel.songId = journal.songId
                                                        return viewModel
                                                    }()
                                                }()), label: {Text(journal.title ?? "Untitled")})
                                                //                                NavigationLink(
                                                //                                    destination: JournalView(viewModel: {
                                                //                                        let viewModel = JournalViewModel()
                                                //                                        viewModel.id = journal.id
                                                //                                        viewModel.data = journal.canvasData
                                                //                                        viewModel.title = journal.title
                                                //                                        viewModel.objectId = journal.objectID
                                                //                                        viewModel.mood = journal.mood
                                                //                                        viewModel.songId = journal.songId
                                                //                                        return viewModel
                                                //                                    }()),
                                                //                                    tag: journal,
                                                //                                    selection: $selectedJournal
                                                //                                ) {
                                                //                                    Text(journal.title ?? "Untitled")
                                                //                                }
                                            }
                                        }
                                        .sheet(isPresented: $isAuthViewShowed, content: {
                                            MusicKitAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus, isAuthViewShowed: $isAuthViewShowed)
                                        })
                                        .padding(.horizontal, geometry.size.width * 0.05)
                                    }

            }
        }
    }
}



//#Preview {
//    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

