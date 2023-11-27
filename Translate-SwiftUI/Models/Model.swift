//
//  Model.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/22/23.
//

import Foundation

//MARK: - Model for list of languages
struct ListResults: Codable {
    var data: Languages
}

struct Languages: Codable {
    var languages: [Language]
}

struct Language: Codable, Hashable {
    var language: String
    var name: String
}

//MARK: - Model for translations
struct ResponseData: Codable {
    var responseData: Translation
}

struct Translation: Codable {
    var translatedText: String
}
