//
//  AddTitleModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI

struct AddTitleModalView: View {
    @EnvironmentObject var router: Router

    @EnvironmentObject var journalVM: JournalViewModel
    @Binding var journalTitle: String
    @Environment(\.dismiss) var dismiss

//    @Binding var addTitleDone: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            HStack {
                Button(action: { dismiss() }, label: {
                    Text("Cancel")
                })
                Spacer()
            }
            Text("Journal Title")
                .font(.title)
                .fontWeight(.semibold)
            TextField("Journal Title", text: $journalTitle)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(16)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                })
                .font(.system(size: 20))

            Button(action: {
                router.navigateTo(.JournalInitMood)
            }) {
                Text("Next")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(journalTitle.isEmpty ? Color.gray : Color.mainBlue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
            .disabled(journalTitle.isEmpty)
            Spacer()
        }
        .background(Color.white)
        .padding(32)
    }
}

#Preview {
//    AddTitleModalView(journalTitle: .constant("Test"))
    RouterView {
        AddTitleModalView(journalTitle: .constant("Test"))
            .environmentObject(JournalViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
