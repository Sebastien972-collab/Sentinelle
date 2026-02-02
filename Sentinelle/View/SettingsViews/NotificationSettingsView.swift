//
//  NotificationSettingsView.swift
//  Sentinelle
//
//  Created by Sebby on 18/11/2024.
//

import SwiftUI

struct NotificationSettingsView: View {
    // MARK: - Properties
    @AppStorage(NotificationManager.notificationKey) private var isNotificationsEnabled: Bool = false
    @AppStorage(NotificationManager.dailyNotificationKey) private var dailyReminder: Bool = false
    @AppStorage(NotificationManager.impactFeedbackKey) private var impactFeedBack: Bool = false
    
    @StateObject private var notificationManager: NotificationManager = NotificationManager()
    
    // Couleur adaptative liquide pour remplacer le flou
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.85)
    }

    var body: some View {
        ZStack {
            // Fond immersif
            SunsetGradientView()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // SECTION HEADER
                    headerSection
                    
                    // GROUPE : ALERTES ET RAPPELS
                    VStack(alignment: .leading, spacing: 12) {
                        sectionLabel("Alertes", systemImage: "bell.badge.fill")
                        
                        VStack(spacing: 0) {
                            // Toggle Maître
                            Toggle(isOn: $isNotificationsEnabled.animation(.spring(response: 0.35, dampingFraction: 0.7))) {
                                Label("Notifications", systemImage: "bell.circle.fill")
                                    .font(.headline)
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .onChange(of: isNotificationsEnabled) { _, newValue in
                                if newValue {
                                    notificationManager.requestAuthorization()
                                }
                            }
                            
                            // Options secondaires (Progressive Disclosure)
                            if isNotificationsEnabled {
                                Divider().padding(.leading, 60)
                                
                                Toggle(isOn: $dailyReminder) {
                                    Label("Rappel quotidien", systemImage: "calendar.badge.clock")
                                        .font(.subheadline)
                                }
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .transition(.move(edge: .top).combined(with: .opacity))
                                .onChange(of: dailyReminder) { _, newValue in
                                    if newValue {
                                        notificationManager.scheduleDailyNotification()
                                    }
                                }
                                
                                Divider().padding(.leading, 60)
                                
                                Button(action: { notificationManager.sendTestNotification() }) {
                                    Label("Tester la notification", systemImage: "paperplane.fill")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .tint(.blue)
                            }
                        }
                        .background(cardColor)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }
                    
                    // GROUPE : SENSORIEL
                    VStack(alignment: .leading, spacing: 12) {
                        sectionLabel("Expérience", systemImage: "hand.tap.fill")
                        
                        Toggle(isOn: $impactFeedBack) {
                            Label("Retour haptique", systemImage: "iphone.radiowaves.left.and.right")
                                .font(.headline)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .background(cardColor)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        
                        Text("Améliore la sensation tactile lors de l'utilisation des boutons et des menus.")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.6))
                            .padding(.horizontal, 12)
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(20)
            }
        }
        .navigationTitle("Réglages")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var headerSection: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "bell.and.waves.left.and.right.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .symbolEffect(.bounce, value: isNotificationsEnabled)
            }
            
            Text("Notifications")
                .font(.system(.title2, design: .serif, weight: .bold))
                .foregroundStyle(.white)
            
            Text("Configurez comment Sentinelle doit vous accompagner dans votre routine.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 30)
        }
        .padding(.vertical, 20)
    }

    private func sectionLabel(_ title: String, systemImage: String) -> some View {
        Label(title, systemImage: systemImage)
            .font(.caption)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .foregroundStyle(.white.opacity(0.6))
            .padding(.leading, 8)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        NotificationSettingsView()
    }
}
