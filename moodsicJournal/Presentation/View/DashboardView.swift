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
//    @StateObject var journalVM = JournalViewModel()
    @StateObject var dashboardVM = DependencyInjection.shared.dashboardViewModel()

    @State private var isAddJournalOpen = false
    @State var musicAuthorizationStatus: MusicAuthorization.Status
    @State var isAuthViewShowed: Bool
    @State private var selectedJournal: Journal?

    @State private var showingSheet = false
    @State private var journalTitle = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    VStack {
                        Image("bg-dashboard")
                            .resizable()
                            .frame(maxWidth: .infinity)
//                            .scaledToFit()
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(maxHeight: .infinity)
                    .background(Color(.lightBlue))

                    ScrollView {
                        // 1. Group the journals by month and sort each group by date
                        let groupedJournals = Dictionary(grouping: dashboardVM.journals) { journal in
                            // Extract month and year from the createdDate
                            let components = Calendar.current.dateComponents([.year, .month], from: journal.createdDate ?? .now)
                            return components
                        }
                        .mapValues { journals in
                            // Sort journals by createdDate in descending order within each month
                            journals.sorted { $0.createdDate ?? .now > $1.createdDate ?? .now }
                        }

                        // 2. Sort groups by month in descending order
                        let sortedGroupedJournals = groupedJournals.sorted {
                            if let date1 = Calendar.current.date(from: $0.key), let date2 = Calendar.current.date(from: $1.key) {
                                return date1 > date2
                            }
                            return false
                        }

                        VStack(alignment: .leading, spacing: 30) {
                            Text("Journal Dashboard")
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.mainBlue))
                            VStack(spacing: 25) {
                                Text("Create New Journal")
                                    .font(.system(size: 20))
                                    .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(Color(.mainBlue))
                                JournalInitModalView(dashboardVM: dashboardVM)
                            }
                            VStack(alignment: .leading, spacing: 25) {
                                ForEach(sortedGroupedJournals, id: \.key) { dateComponents, journals in
                                    if let monthDate = Calendar.current.date(from: dateComponents) {
                                        Text(monthDate, formatter: DateFormatter.monthYear)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color(.mainBlue))
                                    }

                                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 30) {
                                        ForEach(journals) { journal in
                                            JournalThumbnailView(viewModel: {
                                                let viewModel = DependencyInjection.shared.journalViewModel()
                                                viewModel.id = journal.id
                                                viewModel.data = journal.canvasData
                                                viewModel.title = journal.title
                                                viewModel.objectId = journal.objectID
                                                viewModel.mood = journal.mood
                                                viewModel.songId = journal.songId
                                                viewModel.createdDate = journal.createdDate
                                                return viewModel
                                            }(), dashboardVM: dashboardVM)
                                        }
                                    }
                                }
                            }
                            .sheet(isPresented: $isAuthViewShowed, content: {
                                MusicKitAuthorizationView(musicAuthorizationStatus: $musicAuthorizationStatus, isAuthViewShowed: $isAuthViewShowed)
                            })
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .padding(.vertical, geometry.size.height * 0.03)
//                        .padding(.bottom, 150)
                    }
                }
            }
            .onAppear(perform: {
                Task {
                    await dashboardVM.getAllJournals()
                    print("")
                }
            })
            .environmentObject(dashboardVM)
        }
    }
}

#Preview {
    DashboardView(musicAuthorizationStatus: .authorized, isAuthViewShowed: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
