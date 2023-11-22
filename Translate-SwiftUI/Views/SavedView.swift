//
//  SavedView.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/21/23.
//

import Foundation
import SwiftUI

struct SavedView: View {
    var title: String
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(Font.system(size: 18).weight(.bold))
                            .foregroundColor(.black)

                        Text(item)
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundColor(.gray)

                    }
                    Spacer()
                    Image(systemName: "star.fill")
                        .font(Font.system(size: 18).weight(.bold))
                        .foregroundColor(.yellow)
                }
            }
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
    SavedView(title: "Saved View")
}
