//
//  AuthentificationError.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import Foundation


enum AuthentificationError: Error {
    case uknown, appCancel, invalidBioMetrics, biometricLockout
}
extension AuthentificationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .appCancel:
            return "Face ID est désactivé pour cette application dans les réglages."
        case .uknown:
            return "Unknown error."
        case .invalidBioMetrics:
            return "Impossible de détecter les biometriques."
        case .biometricLockout:
            return "Face ID est temporairement verrouillé (trop d'essais ratés)."
        }
    }
}
