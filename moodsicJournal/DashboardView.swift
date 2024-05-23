//
//  DashboardView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Journal.entity(), sortDescriptors: []) var journals:FetchedResults<Journal>

    var body: some View {
        NavigationSplitView(
            sidebar: {},
            detail: {
                VStack(alignment: .leading) {
                    Text("Dashboard")
                    List {
                        ForEach(journals) {
                            journal in
                            Text("Test")
                        }
                    }
                }

            })
    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

