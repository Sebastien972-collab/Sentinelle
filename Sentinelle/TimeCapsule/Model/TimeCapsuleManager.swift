//
//  TimeCapsuleManager.swift
//  Sentinelle
//
//  Created by Sebby on 09/01/2025.
//

import Foundation
import SwiftData
import UserNotifications

@MainActor
class TimeCapsuleManager: ObservableObject {
    static let shared = TimeCapsuleManager() // Singleton
    private init() {} // Empêche l'instanciation directe

    // Propriété publiée pour que SwiftUI réagisse aux modifications
    @Published var capsules: [TimeCapsule] = []
    var notificationsManager: NotificationManager = NotificationManager()
    // MARK: - Charger les capsules
    func fetchCapsules(_ modelContext: ModelContext) {
        do {
            let fetchedCapsules = try modelContext.fetch(FetchDescriptor<TimeCapsule>())
            capsules = fetchedCapsules
        } catch {
            print("Erreur lors du chargement des capsules : \(error)")
        }
    }

    // MARK: - Ajouter une capsule
    func addCapsule(message: String, openDate: Date, modelContext: ModelContext) {
        let newCapsule = TimeCapsule(message: message, openDate: openDate)
        modelContext.insert(newCapsule)

        // Actualiser la liste des capsules
        fetchCapsules(modelContext)

        // Programmer une notification
        notificationsManager.scheduleNotification(for: newCapsule)
    }

    // MARK: - Supprimer une capsule
    func deleteCapsule(_ capsule: TimeCapsule, modelContext: ModelContext) {
        modelContext.delete(capsule)

        // Annuler une notification associée
        notificationsManager.cancelNotification(for: capsule)

        // Actualiser la liste des capsules
        fetchCapsules(modelContext)
    }
}
