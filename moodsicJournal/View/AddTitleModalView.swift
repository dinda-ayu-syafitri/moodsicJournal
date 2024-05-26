//
//  AddTitleModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI

struct AddTitleModalView: View {
    @Binding var journalTitle: String
    @Binding var addTitleDone: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            TextField("Journal Title", text: $journalTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 20))
                .padding(.horizontal, 20)

            Button(action: { addTitleDone = true }) {
                Text("Next")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 15)
            .background(.mainBlue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(radius: 5)
        }
        .background(Color.white)
        .padding()
    }
}

#Preview {
    AddTitleModalView(journalTitle: .constant("Test"), addTitleDone: .constant(false))
}
