//
//  JournalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI
import CoreData
import MusicKit

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: { dismiss() }) {
                                Image(systemName: "chevron.left")
                            }
                            .buttonStyle(PlainButtonStyle())

                            Text(viewModel.title ?? "Untitled")
                            Text(viewModel.mood ?? "No Mood")
                            Text(viewModel.songId ?? "No Selected Song")

                            Spacer()

                            Menu {
                                Button("Delete Journal", action: {
                                    viewModel.deleteJournal(in: viewContext)
                                    dismiss()
                                })
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                        }
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .padding(.vertical, geometry.size.height * 0.02)

                        JournalCanvasView(data: viewModel.data ?? Data(), id: viewModel.id ?? UUID())
                            .environment(\.managedObjectContext, viewContext)
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchSongs()
                    }
                }
                .onDisappear {
                    viewModel.stopMusic()
                }
            }
        }
    }
}



//#Preview {
//    JournalView(id: UUID(), data: Data())
//}
