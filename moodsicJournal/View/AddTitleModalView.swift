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
        VStack {
            Form{
                Section{
                    TextField("Canvas Title", text: $journalTitle)
                }
            }

            Button(action: {addTitleDone = true},
                   label: {
                Text("Save")
            })

        }
    }
}

//#Preview {
//    AddTitleModalView()
//}
