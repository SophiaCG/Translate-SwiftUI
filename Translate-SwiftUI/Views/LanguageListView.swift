//
//  LanguageListView.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/22/23.
//

import Foundation
import SwiftUI

struct LanguageListView: View {
    @State var languageList: [Language] = []     // Name of language (i.e. English)
    @Binding var firstLanguage: Language
    @Binding var secondLanguage: Language
    @Binding var selected: Int
    @Binding var isModalPresented: Bool
    @ObservedObject var networkRequest = NetworkRequest()

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
                ForEach(languageList, id: \.self) { language in
                    Button(action: {
                        if selected == 1 {
                            firstLanguage = language
                        } else {
                            secondLanguage = language
                        }
                        isModalPresented = false
                    }, label: {
                        HStack {
                            Text(language.name)
                                    .font(Font.system(size: 18).weight(.medium))
                                    .foregroundColor(.black)
                        }
                    })
                    .listRowSeparator(.hidden)
                }
            }
        }.onAppear {
            networkRequest.getLanguages { (results) in
                for result in results.data.languages {
                    let language = Language(language: result.language, name: result.name)
                    languageList.append(language)
                }
            }
        }
    }
}
