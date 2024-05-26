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
                            if let mood = viewModel.mood?.lowercased() {
                                Image("dummy-\(mood)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35)
                                    .frame(maxWidth:  .infinity, alignment: .leading)
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
                        .foregroundStyle(Color.mainBlue)
                        .padding(20)
                    })
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
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
