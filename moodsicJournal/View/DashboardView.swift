//
//  DashboardView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import CoreData
import MusicKit
import SwiftUI

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
                ZStack {
                    VStack {
                        Image("bg-dashboard")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(maxHeight: .infinity)
                    .background(.lightBlue)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            Text("Journal Dashboard")
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                                .foregroundStyle(.mainBlue)
                            VStack(spacing: 25) {
                                Text("Create New Journal")
                                    .font(.system(size: 20))
                                    .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.mainBlue)
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
                                                .foregroundStyle(.mainBlue)
                                                .frame(maxWidth: 70)
                                        }
                                })
                                .buttonStyle(PlainButtonStyle())
                                .padding(.bottom, 20)
                            }

                            VStack(alignment: .leading, spacing: 25) {
                                Text("May 2024")
                                    .font(.system(size: 20))
                                    .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.mainBlue)

                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 250) {
                                    ForEach(journals) { journal in
                                        JournalThumbnailView(viewModel: {
                                            let viewModel = JournalViewModel()
                                            viewModel.id = journal.id
                                            viewModel.data = journal.canvasData
                                            viewModel.title = journal.title
                                            viewModel.objectId = journal.objectID
                                            viewModel.mood = journal.mood
                                            viewModel.songId = journal.songId
                                            viewModel.createdDate = journal.createdDate
                                            return viewModel
                                        }())
                                    }
                                }
                                .sheet(isPresented: $isAuthViewShowed, content: {
                                    MusicKitAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus, isAuthViewShowed: $isAuthViewShowed)
                                })
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .padding(.vertical, geometry.size.height * 0.03)
                        .padding(.bottom, 250)
                    }

                    if isAddJournalOpen {
                        Rectangle()
                            .fill(Color.black.opacity(0.5))
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                isAddJournalOpen = false
                            }
                            .overlay(
                                CustomModalView(isAddJournalOpen: $isAddJournalOpen)
                                    .environment(\.managedObjectContext, viewContext)
                                    .frame(height: 400, alignment: .center)
                                    .frame(width: geometry.size.width * 0.60, alignment: .center)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView(musicAuthorizationStatus: .authorized, isAuthViewShowed: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
