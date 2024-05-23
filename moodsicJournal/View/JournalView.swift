//
//  JournalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//

import SwiftUI
import CoreData

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    @State var objectId:NSManagedObjectID?

    @State var isMoodSelected = false

    var body: some View {
        GeometryReader {
            geometry in
            NavigationStack {
                ZStack {
                   if isMoodSelected {
                        VStack(alignment: .leading) {
                            HStack {
                                HStack {
                                    Button(action: {dismiss()}, label: {
                                        Image(systemName: "chevron.left")
                                    })
                                    .buttonStyle(PlainButtonStyle())

                                    Text(title ?? "Untitled")
                                }
                                Spacer()


                                Menu {
                                    Button("Delete Journal", action: {deleteJournal()})
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                }

                            }
                            .padding(.horizontal, geometry.size.width * 0.05)
                            .padding(.vertical, geometry.size.height * 0.02)

                            JournalCanvasView(data: data ?? Data(), id: id ?? UUID())
                                .environment(\.managedObjectContext, viewContext)
                                                        //                    .navigationTitle(title ?? "Untitled")
                        }

                   } else {
                       Rectangle()
                           .frame(width: geometry.size.width, height: geometry.size.height)
                           .ignoresSafeArea()
                           .opacity(0.5)
                           .overlay {
                               RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/) 
                                   .fill(.white)
                                   .overlay
                               {
                                   VStack {
                                       MoodSelectionModalView()
                                           .clipShape(.rect(cornerRadius: 25))
                                           .padding(.horizontal, 50)
                                           .padding(.bottom, 20)
                                       Button(action: {isMoodSelected.toggle()}, label: {
                                           Text("Next")
                                       })
                                   }

                               }
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.35)

                           }
                   }


                }
            }
        }
    }

    private func deleteJournal() {
        guard let objectId = objectId else {
            print("No object ID available to delete")
            return
        }

        do {
            let object = try viewContext.existingObject(with: objectId)
            viewContext.delete(object)

            // Save the context to persist the deletion
            try viewContext.save()
            dismiss()
            print("Object deleted successfully")
        } catch {
            print("Failed to delete object with ID \(objectId): \(error)")
        }
    }
}

#Preview {
    JournalView(id: UUID(), data: Data())
}
