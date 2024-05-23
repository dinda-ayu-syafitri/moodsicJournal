//
//  AddNewJournalModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct AddNewJournalModalView: View {

    @Environment (\.managedObjectContext) var viewContext
    @Environment (\.dismiss) var dismiss

    @State private var canvasTitle = ""

    var body: some View {
        NavigationView{
            VStack {
                Form{
                    Section{
                        TextField("Canvas Title", text: $canvasTitle)
                    }
                }

                Button(action: {newJournal()},
                       label: {
                    Text("Save")
                })
            }
        }
    }

    private func newJournal() {
        withAnimation {
            let newItem = Journal(context: viewContext)
            newItem.title = canvasTitle
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



#Preview {
    AddNewJournalModalView()
}
