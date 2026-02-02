//
//  SecurityView.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import SwiftUI

struct SecurityView: View {
    // MARK: - Properties
    @AppStorage("isAuthEnabled") private var authEnable: Bool = false
    @AppStorage("digitalPasswordEnabled") private var digitPassEnable: Bool = false
    
    private let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // Couleur adaptative liquide pour les cartes
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.85)
    }

    var body: some View {
        ZStack {
            // Fond immersif cohérent avec le reste de l'app
            SunsetGradientView()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // HEADER : ÉTAT DE LA PROTECTION
                    securityHeader
                    
                    // SECTION : AUTHENTIFICATION
                    VStack(alignment: .leading, spacing: 12) {
                        sectionLabel("Accès à l'application", systemImage: "shield.fill")
                        
                        VStack(spacing: 0) {
                            // Toggle FaceID / TouchID
                            Toggle(isOn: $authEnable.animation(.spring(response: 0.35, dampingFraction: 0.7))) {
                                Label {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Face ID / Touch ID")
                                            .font(.headline)
                                        Text("Déverrouillage biométrique")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                } icon: {
                                    Image(systemName: "faceid")
                                        .font(.title3)
                                        .foregroundStyle(.blue)
                                }
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            
                            Divider().padding(.leading, 60)
                            
                            // Option Mot de passe (Placeholder UX)
                            HStack {
                                Label("Code numérique", systemImage: "key.fill")
                                    .font(.headline)
                                Spacer()
                                Text("Bientôt")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.blue.opacity(0.1))
                                    .foregroundStyle(.blue)
                                    .clipShape(Capsule())
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .opacity(0.6)
                        }
                        .background(cardColor)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }
                    
                    // SECTION : LÉGAL & INFOS
                    VStack(alignment: .leading, spacing: 12) {
                        sectionLabel("Confidentialité", systemImage: "hand.raised.fill")
                        
                        VStack(spacing: 0) {
                            NavigationLink {
                                PrivacyPolicyView()
                            } label: {
                                HStack {
                                    Label("Politique de confidentialité", systemImage: "doc.text.fill")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 18)
                                .padding(.horizontal, 20)
                            }
                            .buttonStyle(.plain)
                            
                            Divider().padding(.leading, 60)
                            
                            HStack {
                                Label("Version", systemImage: "app.badge.fill")
                                    .font(.subheadline)
                                Spacer()
                                Text(version ?? "1.0.0")
                                    .font(.subheadline)
                                    .monospacedDigit()
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 18)
                            .padding(.horizontal, 20)
                        }
                        .background(cardColor)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(20)
            }
        }
        .navigationTitle("Sécurité")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var securityHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(authEnable ? Color.green.opacity(0.15) : Color.white.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: authEnable ? "shield.checkered" : "shield.slash.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(authEnable ? .green : .white)
                    // Animation réactive au changement d'état
                    .symbolEffect(.bounce, value: authEnable)
            }
            
            Text(authEnable ? "Journal Sécurisé" : "Protection inactive")
                .font(.system(.title3, design: .serif, weight: .bold))
                .foregroundStyle(.white)
            
            Text("L'accès à vos pensées est protégé par les couches de sécurité de votre iPhone.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))
                .padding(.horizontal, 40)
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
        SecurityView()
    }
}
