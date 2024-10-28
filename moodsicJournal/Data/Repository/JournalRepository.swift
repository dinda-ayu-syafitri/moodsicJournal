//
//  JournalRepository.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/10/24.
//

import Foundation

class JournalRepository: JournalRepositoryProtocol {
    private let journalLocalDataSource: JournalLocalDataSource
    init(journalLocalDataSource: JournalLocalDataSource) {
        self.journalLocalDataSource = journalLocalDataSource
    }

    func getJournal() async throws -> [Journal] {
        let localData = try await journalLocalDataSource.getJournal()

        return localData
    }

    func insertJournal(journal: Journal) async throws {}

    func updateJournal(journal: Journal) async throws {}

    func deleteJournal(id: UUID) async throws {}
}
