//
//  JournalInitModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 06/10/24.
//

import SwiftUI

struct JournalInitModalView: View {
    @StateObject var journalInitVM: JournalInitViewModel
    @State private var isAddJournalOpen = false
    @State private var currentView: ModalView = .titleInput

    @State private var journalTitle = ""
    @State private var MoodSelected = ""
    @State private var playlistID = ""

    init(dashboardVM: DashboardViewModel) {
        _journalInitVM = StateObject(wrappedValue: JournalInitViewModel(dashboardVM: dashboardVM))
    }

    var body: some View {
        VStack {
            Button(action: {
                isAddJournalOpen.toggle()
            }, label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.white)
                    .frame(width: 200, height: 200)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
                    .overlay {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color(.mainBlue))
                            .frame(maxWidth: 70)
                    }
            })
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 20)
            .sheet(isPresented: $isAddJournalOpen) {
                switch currentView {
                    case .titleInput:
                        AddTitleModalView(currentView: $currentView)
                    case .moodSelection:
                        MoodSelectionModalView(currentView: $currentView)
                    case .musicSelection:
                        MusicRecommendationModalView(currentView: $currentView)
                }
            }
        }
        .environmentObject(journalInitVM)
    }
}

#Preview {
    JournalInitModalView(dashboardVM: DependencyInjection.shared.dashboardViewModel())
}
