//
//  JournalCanvasView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//


import SwiftUI
import CoreData

struct JournalCanvasView: UIViewControllerRepresentable {
    @Environment (\.managedObjectContext) private var viewContext

    func updateUIViewController(_ uiViewController: JournalViewController, context: Context) {
        uiViewController.journalData = data
    }
    typealias UIViewControllerType = JournalViewController

    var data: Data
    var id: UUID

    func makeUIViewController(context: Context) -> JournalViewController {
        let viewController = JournalViewController()
        viewController.journalData = data
        viewController.journalChanged = { data in
            let request: NSFetchRequest<Journal> = Journal.fetchRequest()
            let predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.predicate = predicate
            do{
                let result = try viewContext.fetch(request)
                let obj = result.first
                obj?.setValue(data, forKey: "canvasData")
                do{
                    try viewContext.save()
                }
                catch{
                    print(error)
                }
            }
            catch{
                print(error)
            }
        }
        return viewController
    }

}
