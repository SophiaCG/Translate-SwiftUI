//
//  NetworkRequest.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/22/23.
//

import Foundation

class NetworkRequest: ObservableObject {
    
    @Published var languages = [Language]()     // Language list (array)
    
    @Published var input: String = ""           // Text entered by user to translate
    @Published var translation: String = ""     // Translation of input
    @Published var sourceLang: String = "en"    // Language of input
    @Published var targetLang: String = "fr"    // Language of translation
    
//MARK: - Language List API Call
    func getLanguages(completion:@escaping (ListResults) -> ()) {
        
        guard let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2/languages?target=en&rapidapi-key=\(Key.apiKey)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
                print("TASK ERROR 1: \(String(describing: error))")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(ListResults.self, from: data!)
                
                DispatchQueue.main.async {
                    self.languages = results.data.languages
                    completion(results)
                }
            } catch {
                print("RESULTS ERROR 1: \(error)")
            }
        }
        task.resume()
    }

//MARK: - Translation API Call
    func translate(input: String, sourceLang: String, targetLang: String, completion:@escaping (ResponseData) -> ()) {

        self.input = input.replacingOccurrences(of: " ", with: "%20")
        print("Translating from \(sourceLang) to \(targetLang)")
        let urlString = "https://translated-mymemory---translation-memory.p.rapidapi.com/get"
        let queryParams = [
            "langpair": "\(sourceLang)|\(targetLang)",
            "q": input,
            "mt": "1",
            "onlyprivate": "0",
            "de": "a@b.c",
            "rapidapi-key": Key.apiKey
        ]

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }

        if let url = urlComponents?.url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard data != nil else {
                    print("TASK ERROR 2: \(String(describing: error))")
                    return
                }

                do {
                    let results = try JSONDecoder().decode(ResponseData.self, from: data!)
                    print("TRANSLATION: \(results.responseData.translatedText)")
                    
                    DispatchQueue.main.async {
                        self.translation = results.responseData.translatedText
                        completion(results)
                    }
                } catch {
                    print("RESULTS ERROR 2: \(error)")
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}
