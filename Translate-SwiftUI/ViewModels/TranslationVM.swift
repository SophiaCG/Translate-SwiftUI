//
//  TranslationVM.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/26/23.
//

import SwiftUI
import CoreData

class TranslationViewModel: ObservableObject {
    @Published var translations: [SavedTranslation] = []

    // MARK: - Core Data Operations

    func addTranslation(input: String, translation: String, timestamp: Date) {
        let newTranslation = SavedTranslation(context: PersistenceController.shared.container.viewContext)
        newTranslation.input = input
        newTranslation.translation = translation
        newTranslation.timestamp = timestamp

        PersistenceController.shared.saveContext()
        fetchTranslations()
    }

    func deleteTranslation(input: String, translation: String) {
        let fetchRequest: NSFetchRequest<SavedTranslation> = NSFetchRequest<SavedTranslation>(entityName: "SavedTranslation")
        fetchRequest.predicate = NSPredicate(format: "input == %@ AND translation == %@", input, translation)

        do {
            let matchingTranslations = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)

            // Assuming there should be at most one matching translation
            if let matchingTranslation = matchingTranslations.first {
                PersistenceController.shared.deleteEntry(matchingTranslation)
                fetchTranslations()
            } else {
                print("No matching translation found for input '\(input)' and translation '\(translation)'.")
            }
        } catch {
            print("Error fetching translations for deletion: \(error)")
        }
    }

    func translationExists(input: String, translation: String) -> Bool {
        let predicate = NSPredicate(format: "input == %@ AND translation == %@", input, translation)
        return PersistenceController.shared.entryExists(forEntity: "SavedTranslation", withPredicate: predicate)
    }

    func fetchTranslations() {
        let fetchRequest: NSFetchRequest<SavedTranslation> = NSFetchRequest<SavedTranslation>(entityName: "SavedTranslation")

        do {
            translations = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching translations: \(error)")
        }
    }
}
