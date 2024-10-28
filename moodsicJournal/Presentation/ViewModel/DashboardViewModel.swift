//
//  DashboardViewModel.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/10/24.
//

import Foundation

class DashboardViewModel: ObservableObject {
    private let getAllJournalUseCase: GetAllJournalUseCase

    init(getAllJournalUseCase: GetAllJournalUseCase) {
        self.getAllJournalUseCase = getAllJournalUseCase
    }

    @Published var journals: [Journal] = []

    @MainActor
    func getAllJournals() async {
        do {
            journals = try await getAllJournalUseCase.execute()
        } catch {
            print("Failed to fetch journals: \(error)")
        }
    }
}
