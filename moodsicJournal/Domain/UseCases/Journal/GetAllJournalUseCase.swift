//
//  GetAllJournalUseCase.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/10/24.
//

import Foundation

protocol GetAllJournalUseCase {
    func execute() async throws -> [Journal]
}

class GetAllJournalUseCaseImpl: GetAllJournalUseCase {
    private let journalRepository: JournalRepository

    init(journalRepository: JournalRepository) {
        self.journalRepository = journalRepository
    }

    func execute() async throws -> [Journal] {
        let journals = try await journalRepository.getJournal()
        return journals
    }
}
