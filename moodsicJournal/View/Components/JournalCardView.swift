//
//  JournalCardView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 26/05/24.
//

import PencilKit
import SwiftUI

struct JournalCardView: View {
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        NavigationLink(destination: JournalView(viewModel: viewModel)) {
            RoundedRectangle(cornerRadius: 25.0)
                .padding(10)
                .background(.blue)
                .frame(width: 215, height: 215)
                .border(.black, width: 1)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(Color.clear)
                        .background(
                            Group {
                                if let journalData = viewModel.data,
                                   let drawing = try? PKDrawing(data: journalData)
                                {
                                    Image(uiImage: drawing.toImage(size: CGSize(width: 1000, height: 1000)))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                } else {
                                    Color.gray
                                }
                            }
                        )
                        .overlay(
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
                        )
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
//                        .shadow(radius: 10)
                })
                .padding(10)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    JournalCardView(viewModel: {
        let viewModel = JournalViewModel()
        viewModel.id = UUID()
        viewModel.title = "Journal Title"
        viewModel.mood = "Happy"
        viewModel.songId = "12123"
        return viewModel
    }())
}
