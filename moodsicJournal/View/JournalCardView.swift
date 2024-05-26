//
//  JournalCardView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 26/05/24.
//

import SwiftUI

struct JournalCardView: View {
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        GeometryReader {
            geometry in
            NavigationLink(destination: JournalView(viewModel: viewModel)) {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.white)
                    .frame(width: 215, height: 215)
                    .overlay(content: {
                        VStack(alignment: .trailing) {
                            Spacer()
                            Text(viewModel.title ?? "Untitled")
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text(viewModel.createdDate?.formatted(date: .long, time: .omitted) ?? "21 May 2024")
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(geometry.size.width * 0.03)
                    })
                    .shadow(radius: 10)
            }


        }


    }
}

#Preview {
    JournalCardView(viewModel: {
        {
            let viewModel = JournalViewModel()
            viewModel.id = UUID()
            viewModel.title = "Journal Title"
            viewModel.mood = "Happy"
            viewModel.songId = "12123"
            return viewModel
        }()
    }())
}
