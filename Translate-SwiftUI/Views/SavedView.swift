//
//  SavedView.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/21/23.
//

import Foundation
import SwiftUI

struct SavedView: View {
    enum SortOrder {
        case alphabetical
        case byTime
    }

    @StateObject private var translationVM = TranslationViewModel()
    @State private var sortOrder: SortOrder = .alphabetical

    var sortedTranslations: [SavedTranslation] {
        switch sortOrder {
        case .alphabetical:
            return translationVM.translations.sorted(by: { $0.input ?? "" < $1.input ?? "" })
        case .byTime:
            return translationVM.translations.sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })
        }
    }

    var body: some View {
        List(sortedTranslations, id: \.self) { (translation: SavedTranslation) in
            if translationVM.translations.count == 0 {
                Text("Star a translation to see it here")
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(translation.input ?? "")
                            .font(Font.system(size: 18).weight(.bold))
                            .foregroundColor(.black)

                        Text(translation.translation ?? "")
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.gray)

                    }
                    Spacer()
                    Button(action: {
                        if translationVM.translationExists(input: translation.input  ?? "", translation: translation.translation ?? "") {
                            translationVM.deleteTranslation(input: translation.input ?? "", translation: translation.translation ?? "")
                        }
                    }) {
                        Image(systemName: translationVM.translationExists(input: translation.input  ?? "", translation: translation.translation ?? "") ? "star.fill" : "star")
                            .font(Font.system(size: 18).weight(.bold))
                            .foregroundColor(translationVM.translationExists(input: translation.input ?? "", translation: translation.translation ?? "") ? .yellow : .gray)
                    }
                }
            }
        }
        .onAppear {
            translationVM.fetchTranslations()
        }
        .listStyle(PlainListStyle())
            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: HStack {
                    Image(systemName: "arrow.clockwise")
                        .font(Font.system(size: 15).weight(.bold))
                        .foregroundColor(.black)
                    Menu {
                        Button {
                            sortOrder = .alphabetical
                        } label: {
                            HStack {
                                Image(systemName: sortOrder == .alphabetical ? "checkmark" : "")
                                    .font(.system(size: 20).weight(.bold))
                                    .foregroundColor(.gray)
                                    .layoutPriority(10)

                                Text("Sort alphabetically")
                            }
                        }
                        
                        Button {
                            sortOrder = .byTime
                        } label: {
                            HStack {
                                Text("Sort by time")

                                Image(systemName: sortOrder == .byTime ? "checkmark" : "")
                                    .font(.system(size: 20).weight(.bold))
                                    .foregroundColor(.gray)
                                    .layoutPriority(2)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(Font.system(size: 15).weight(.bold))
                            .foregroundColor(.black)
                            .padding(5)

                    }

                }
            )

    }
}

#Preview {
    SavedView()
}
