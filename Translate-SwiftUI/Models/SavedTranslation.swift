//
//  SavedTranslation.swift
//  Translate-SwiftUI
//
//  Created by Sophia Gorgonio on 11/27/23.
//

import Foundation
import CoreData

@objc(SavedTranslation)
public class SavedTranslation: NSManagedObject {
    @NSManaged public var input: String?
    @NSManaged public var translation: String?
    @NSManaged public var timestamp: Date?
}
