//
//  JournalInitModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 06/10/24.
//

import SwiftUI

struct JournalInitModalView: View {
    @State private var isAddJournalOpen = false
    @State private var journalTitle = ""

    var body: some View {
        VStack {
            Button(action: {
                isAddJournalOpen.toggle()
            }, label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.white)
                    .frame(width: 200, height: 200)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
                    .overlay {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.mainBlue)
                            .frame(maxWidth: 70)
                    }
            })
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 20)
            .sheet(isPresented: $isAddJournalOpen) {
                AddTitleModalView(journalTitle: $journalTitle)
            }
        }
    }
}

#Preview {
    JournalInitModalView()
}
