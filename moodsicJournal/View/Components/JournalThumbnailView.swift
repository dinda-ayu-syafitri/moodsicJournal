//
//  JournalThumbnailView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 28/09/24.
//

import PencilKit
import SwiftUI

struct JournalThumbnailView: View {
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        NavigationLink(destination: JournalView(viewModel: viewModel)) {
            VStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color.clear)
                    .background(
                        Group {
                            if let journalData = viewModel.data,
                               let drawing = try? PKDrawing(data: journalData)
                            {
                                Image(uiImage: drawing.toImage(size: CGSize(width: 1000, height: 1000)))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)

                            } else {
                                Color.gray
                            }
                        }
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(minWidth: 200, minHeight: 200)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
//                    .overlay(content: {
//                        RoundedRectangle(cornerRadius: 20)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .frame(minWidth: 200, minHeight: 200)
//                            .background(.clear)
//                            .border(.gray, width: 1)
//
//                    })
                    .padding(10)

                VStack(alignment: .trailing) {
                    if let mood = viewModel.mood?.lowercased() {
                        Image("dummy-\(mood)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    Text(viewModel.title ?? "Untitled")
                        .font(.system(size: 15, weight: .bold))
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 5)
                    Text(viewModel.createdDate?.formatted(date: .long, time: .omitted) ?? "21 May 2024")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .foregroundColor(Color.mainBlue)
                .padding(20)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(radius: 10)
        }
    }
}

#Preview {
    JournalThumbnailView(viewModel: {
        let viewModel = JournalViewModel()
        viewModel.id = UUID()
        viewModel.title = "Journal Title"
        viewModel.mood = "Happy"
        viewModel.songId = "12123"
        return viewModel
    }())
}
