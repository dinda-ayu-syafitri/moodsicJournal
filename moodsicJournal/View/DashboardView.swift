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

    @FetchRequest(entity: Journal.entity(), sortDescriptors: [])
    private var journals: FetchedResults<Journal>

    @State private var isAddJournalOpen = false

    var body: some View {
        GeometryReader {
            geometry in
            NavigationSplitView(
                sidebar: {},
                detail: {
                    VStack(alignment: .leading) {
                        Text("Dashboard")
                        Button(action: {
                            isAddJournalOpen.toggle()
                        }, label: {
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(.white)
                                .frame(width: 200, height: 200)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .overlay {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundStyle(Color.blue)
                                        .frame(maxWidth: 70)
                                }
                        })
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $isAddJournalOpen, content: {
                            CustomModalView().environment(\.managedObjectContext, viewContext)
                        })
                        .padding(.bottom, 20)

                        List {
                            ForEach(journals){journal in
                                NavigationLink(destination: JournalView(id: journal.id, data: journal.canvasData, title: journal.title, objectId: journal.objectID, mood: journal.mood, isMoodSelected: true), label: {
                                    Text(journal.title ?? "Untitled")
                                })

                            }
                        }
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)
                })
        }


    }
}

#Preview {
    DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

