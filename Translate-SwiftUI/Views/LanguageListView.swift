//
//  LanguageListView.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/22/23.
//

import Foundation
import SwiftUI

struct LanguageListView: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    @Binding var isModalPresented: Bool
    @ObservedObject var viewModel = ViewModel()
    @State var names: [String] = []     // Name of language (i.e. English)
    @State var codes: [String] = []     // Code of language (i.e. en)

    var body: some View {
        HStack {
            Text("Translate from")
                .font(Font.system(size: 18).weight(.bold))
                .foregroundColor(.black)
                .frame(width: 300, height: 50, alignment: .center)
                .offset(x: 10)

            Button(action: {isModalPresented = false}, label: {
                Image(systemName: "multiply.circle.fill")
                    .font(Font.system(size: 25).weight(.bold))
                    .foregroundColor(.gray)
            })
        }

        List {
            Section(header: Text("ALL LANGUAGES").fontWeight(.medium)) {
                ForEach(names, id: \.self) { name in
                    HStack {
                            Text(name)
                                .font(Font.system(size: 18).weight(.medium))
                                .foregroundColor(.black)
                    }.listRowSeparator(.hidden)
                }
            }
        }.onAppear {
            ViewModel().getLanguages { (results) in
                for result in results.data.languages {
                    names.append(result.name)
                    codes.append(result.language)
                }
            }
        }
    }
}
