//
//  NotificationManager.swift
//  Sentinelle
//
//  Created by Sebby on 21/11/2024.
//

import Foundation
import UIKit
import UserNotifications

class NotificationManager: ObservableObject {
    static let notificationKey = "isNotificationEnabled"
    static let dailyNotificationKey = "dailyNotificationEnabled"
    static let timeCapsuleNotificationKey = "timeCapsuleNotificationEnabled"
    static let impactFeedbackKey = "impactFeedbackEnabled"
    @Published var errorLocalzedDescription: String  = ""
    @Published var showError: Bool = false
    
    func notifcationContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        return content
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                UserDefaults.standard.set(true, forKey: NotificationManager.notificationKey)
            } else if let error {
                UserDefaults.standard.set(false, forKey: NotificationManager.notificationKey)
                self.errorLocalzedDescription = error.localizedDescription
                self.showError = true
            }
        }
    }
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Rendez-vous quotidien"
        content.body = "Il est 20h, prenez un moment pour ouvrir votre coeur ou réfléchir à votre journée."
        content.sound = .default

        // Déclencheur immédiat
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        // Création de la requête
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Ajouter la notification au centre de notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de l'envoi de la notification : \(error.localizedDescription)")
                self.errorLocalzedDescription = error.localizedDescription
                self.showError = true
            } else {
                print("Notification envoyée avec succès !")
            }
        }
    }
    func scheduleNotification(title: String, body: String, date: Date) {
        guard UserDefaults.standard.bool(forKey: NotificationManager.timeCapsuleNotificationKey) else { return }
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default

            // Créer un déclencheur basé sur la date
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

            // Identifier unique pour la notification
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // Ajouter la notification au centre de notifications
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Erreur lors de la planification de la notification : \(error.localizedDescription)")
                } else {
                    print("Notification planifiée pour le \(date)")
                }
            }
        }
    func scheduleDailyNotification() {
        guard UserDefaults.standard.bool(forKey: NotificationManager.dailyNotificationKey) else { return }
        let content = UNMutableNotificationContent()
        content.title = "Prends un moment pour toi 🌙"
        content.body = "Écris tes pensées du jour. Ton futur toi te remerciera. ✨"
        
        content.sound = .default

        // Définir l'heure pour 20h
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 0

        // Déclencheur basé sur le calendrier
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Créer la requête
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        // Ajouter la notification au centre de notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de la planification de la notification : \(error.localizedDescription)")
                self.errorLocalzedDescription = error.localizedDescription
                self.showError = true
            } else {
                print("Notification quotidienne planifiée à 20h.")
            }
        }
    }
    
    static func triggerImpactFeedback() {
        guard UserDefaults.standard.bool(forKey: NotificationManager.impactFeedbackKey) else { return }
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
        
    }
    // MARK: - Programmer une notification
     func scheduleNotification(for capsule: TimeCapsule) {
         scheduleNotification(title:  "Capsule temporelle prête à être ouverte !", body: "Votre capsule créée le \(capsule.creationDate.formatted()) est maintenant disponible.", date: capsule.openDate)
    }

    // MARK: - Annuler une notification
     func cancelNotification(for capsule: TimeCapsule) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [capsule.id.uuidString])
    }
}

