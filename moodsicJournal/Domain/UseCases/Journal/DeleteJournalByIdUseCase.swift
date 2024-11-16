//
//  DeleteJournalByIdUseCase.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 16/11/24.
//

import Foundation

protocol DeleteJournalByIdUseCase {
    func execute(id: UUID) async throws
}

class DeleteJournalByIdUseCaseImpl: DeleteJournalByIdUseCase {
    private let journalRepository: JournalRepository

    init(journalRepository: JournalRepository) {
        self.journalRepository = journalRepository
    }

    func execute(id: UUID) async throws {
        do {
            try await journalRepository.deleteJournal(id: id)
        }
        catch {
            print("Error deleting journal: \(error.localizedDescription)")
        }
    }
}
