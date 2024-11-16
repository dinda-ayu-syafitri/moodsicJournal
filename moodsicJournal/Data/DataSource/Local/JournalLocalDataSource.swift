//
//  JournalLocalDataSource.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 27/10/24.
//

import CoreData

class JournalLocalDataSource: JournalLocalDataSourceProtocol {
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getJournal() async throws -> [Journal] {
        let fetchRequest = NSFetchRequest<Journal>(entityName: "Journal")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Journal.createdDate, ascending: false)]
        do {
            let journals = try context.fetch(fetchRequest)
            return journals
        } catch {
            throw error
        }
    }

    func insertJournal(journal: Journal) async throws {
        context.insert(journal)
        try context.save()
    }

    func updateJournal(journal: Journal) async throws {
        if context.hasChanges {
            try context.save()
        }
    }

    func deleteJournal(id: UUID) async throws {
        let fetchRequest = NSFetchRequest<Journal>(entityName: "Journal")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let journals = try context.fetch(fetchRequest)
            if let journalToDelete = journals.first {
                context.delete(journalToDelete)
                try context.save()
            }
        } catch {
            throw error
        }
    }
}
