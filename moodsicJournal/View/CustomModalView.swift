//
//  CustomModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI

struct CustomModalView: View {
    @Environment (\.managedObjectContext) var viewContext
    @Environment (\.dismiss) var dismiss

    @State private var journalTitle = ""
    @State private var mood = ""
    @State private var isSaved = false
    @State private var addTitleDone = false

    var body: some View {
        NavigationStack{
            if !addTitleDone {
                AddTitleModalView(journalTitle: $journalTitle, addTitleDone: $addTitleDone)
            } else {
                VStack {
                    MoodSelectionModalView(selectedMood: $mood)
                    Button(action: {newJournal()}, label: {
                        Text("Save")
                    })
                }
            }

        }
    }


    private func newJournal() {
        withAnimation {
            let newItem = Journal(context: viewContext)
            newItem.title = journalTitle
            newItem.mood = mood
            newItem.id = UUID()

            do {
                try viewContext.save()
                dismiss()
                isSaved = true
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    CustomModalView()
}
