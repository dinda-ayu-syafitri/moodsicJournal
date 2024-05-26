//
//  AddTitleModalView.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import SwiftUI

struct AddTitleModalView: View {
    @Binding var journalTitle:String
    @Binding var addTitleDone:Bool

    var body: some View {
            VStack(spacing: 20) {
                Text("Enter Canvas Title")
                    .font(.headline)
                    .padding(.top)

                TextField("Canvas Title", text: $journalTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 20)

                Button(action: { addTitleDone = true }) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing, .bottom], 20)
            }
            .background(Color.white)
            .padding()
        }
}

//#Preview {
//    AddTitleModalView(journalTitle: <#Binding<String>#>, addTitleDone: <#Binding<Bool>#>)
//}
