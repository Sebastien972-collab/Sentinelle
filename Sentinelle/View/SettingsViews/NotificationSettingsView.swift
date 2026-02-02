//
//  NotificationSettingsView.swift
//  Sentinelle
//
//  Created by Sebby on 18/11/2024.
//

import SwiftUI

struct NotificationSettingsView: View {
    @AppStorage(NotificationManager.notificationKey) private var isNotificationsEnabled: Bool = false
    @AppStorage(NotificationManager.dailyNotificationKey) private var dailyReminder: Bool = false
    @AppStorage(NotificationManager.timeCapsuleNotificationKey) private var timeCapsule: Bool = false
    @AppStorage(NotificationManager.impactFeedbackKey) private var impactFeedBack: Bool = false
    @StateObject private var notificationManager: NotificationManager = NotificationManager()
    
    var body: some View {
        Form {
            Section(header: Text("Notifications")) {
                withAnimation {         
                    Toggle(isOn: $isNotificationsEnabled, label: {
                        Label("Activez les notifications", systemImage: "bell.circle")
                    })
                    .onChange(of: isNotificationsEnabled) {
                        notificationManager.requestAuthorization()
                    }
                }
                if isNotificationsEnabled {
                    Toggle(isOn: $dailyReminder, label: {
                        Label("Rappel d'écriture quotidien", systemImage: "square.and.pencil")
                    })
                    .onChange(of: dailyReminder) {
                        notificationManager.scheduleDailyNotification()
                    }
                    //                    Toggle(isOn: $timeCapsule, label: {
                    //                        Label("Capsule temporelle", systemImage: "clock.arrow.trianglehead.2.counterclockwise.rotate.90")
                    //                    })
                    Button("Envoyer une notification de test"){
                        notificationManager.sendTestNotification()
                    }
                }
            }
            Section {
                Toggle(isOn: $impactFeedBack, label: {
                    Label("Activer les haptiques", systemImage: "iphone.gen3.radiowaves.left.and.right.circle")
                })
            } header: {
                Text("Retour haptiques")
            }

        }
    }
}


#Preview {
    NotificationSettingsView()
}
