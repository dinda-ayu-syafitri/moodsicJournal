//
//  JournalLocalDataSourceProtocol.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/10/24.
//

import Foundation

protocol JournalLocalDataSourceProtocol {
    func getJournal() async throws -> [Journal]
    func insertJournal(journal: Journal) async throws
    func updateJournal(journal: Journal) async throws
    func deleteJournal(id: UUID) async throws
}
