//
//  SavedView.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/21/23.
//

import Foundation
import SwiftUI

struct SavedView: View {
    @StateObject private var translationVM = TranslationViewModel()

    var body: some View {
        List(translationVM.translations, id: \.self) { (translation: SavedTranslation) in
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
                    Image(systemName: "slider.horizontal.3")
                        .font(Font.system(size: 15).weight(.bold))
                        .foregroundColor(.black)
                        .padding(5)
                }
            )

    }
}

#Preview {
    SavedView()
}
