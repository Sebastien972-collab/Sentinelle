//
//  JournalError.swift
//  Sentinelle
//
//  Created by Sebby on 21/11/2024.
//

import Foundation

enum JournalError: Error {
    case uknown, fieldIsEmpty
}
extension JournalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fieldIsEmpty:
            return "Le champ text ne peut pas être vide."
        case .uknown:
            return "Unknown error."
        }
    }
}
