//
//  DashboardView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext


    var body: some View {
        NavigationSplitView(
            sidebar: {},
            detail: {
                Text("Dashboard")
            })
    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

