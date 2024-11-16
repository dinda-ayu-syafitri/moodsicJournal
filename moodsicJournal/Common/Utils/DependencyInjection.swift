//
//  DependencyInjection.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/10/24.
//

import CoreData
import Foundation

class DependencyInjection: ObservableObject {
    static let shared = DependencyInjection()

    private var context: NSManagedObjectContext?

    func initializer(context: NSManagedObjectContext) {
        self.context = context
    }

    lazy var journalLocalDataSource = JournalLocalDataSource(context: context!)
    lazy var journalRepository = JournalRepository(journalLocalDataSource: journalLocalDataSource)

    // MARK: IMPLEMENTATION USE CASE - JOURNAL

    lazy var getAllJournalUseCase = GetAllJournalUseCaseImpl(journalRepository: journalRepository)
    lazy var deleteJournalByIdUseCase = DeleteJournalByIdUseCaseImpl(journalRepository: journalRepository)

    // MARK: VIEWMODEL

    func dashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(getAllJournalUseCase: getAllJournalUseCase)
    }

    @MainActor func journalViewModel() -> JournalViewModel {
        JournalViewModel(deleteJournalByIdUseCase: deleteJournalByIdUseCase)
    }
}
