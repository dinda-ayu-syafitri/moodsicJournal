//
//  JournalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State var id:UUID?
    @State var data:Data?
    @State var title:String?

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {dismiss()}, label: {
                    Image(systemName: "chevron.left")
                })
                .buttonStyle(PlainButtonStyle())

                JournalCanvasView(data: data ?? Data(), id: id ?? UUID())
                    .environment(\.managedObjectContext, viewContext)
                    .navigationTitle(title ?? "Untitled")
            }
        }

    }
}

#Preview {
    JournalView(id: UUID(), data: Data())
}
