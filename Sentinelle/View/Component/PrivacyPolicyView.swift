//
//  PrivacyPolicyView.swift
//  Sentinelle
//
//  Created by Sebby on 21/11/2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    // Couleur adaptative liquide
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.85)
    }
    
    var body: some View {
        ZStack {
            // Fond immersif
            SunsetGradientView().ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 24) {
                    
                    // HEADER : RÉASSURANCE
                    headerSection
                    
                    // HIGHLIGHTS (Résumé rapide pour l'utilisateur pressé)
                    highlightsGrid
                    
                    // CONTENU DÉTAILLÉ
                    VStack(spacing: 20) {
                        privacySection(
                            title: "Données personnelles",
                            icon: "person.badge.shield.fill",
                            content: "Nous ne collectons aucune information personnelle identifiable (nom, email, etc.). Vos journaux et données émotionnelles sont stockés exclusivement sur votre appareil."
                        )
                        
                        privacySection(
                            title: "Sécurité locale",
                            icon: "lock.icloud.fill",
                            content: "Toutes vos entrées sont protégées par le cryptage local de votre iPhone et vos méthodes de verrouillage habituelles (FaceID, Code)."
                        )
                        
                        privacySection(
                            title: "Zéro Partage",
                            icon: "eye.slash.fill",
                            content: "Aucune donnée n'est envoyée à des serveurs tiers ou utilisée à des fins publicitaires. Votre vie privée est un circuit fermé."
                        )
                        
                        privacySection(
                            title: "Contrôle Total",
                            icon: "slider.horizontal.3",
                            content: "Vous pouvez modifier ou supprimer vos données à tout moment. Rien n'est conservé ou synchronisé sans votre action explicite."
                        )
                    }
                    
                    footerSection
                }
                .padding(20)
            }
        }
        .navigationTitle("Confidentialité")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.raised.square.on.square.fill")
                .font(.system(size: 44))
                .foregroundStyle(.white)
                .padding(.bottom, 5)
            
            Text("Votre vie privée avant tout")
                .font(.system(.title2, design: .serif, weight: .bold))
                .foregroundStyle(.white)
            
            Text("Dernière mise à jour : 21 Novembre 2024")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
        }
        .padding(.vertical, 10)
    }

    private var highlightsGrid: some View {
        HStack(spacing: 12) {
            highlightItem(icon: "iphone", text: "Stockage Local")
            highlightItem(icon: "cloud.badge.slash", text: "Zéro Cloud")
            highlightItem(icon: "megaphone.slash", text: "Sans Pub")
        }
    }

    private func highlightItem(icon: String, text: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.blue)
            Text(text)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func privacySection(title: String, icon: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            Text(content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    private var footerSection: some View {
        VStack(spacing: 12) {
            Text("Des questions ?")
                .font(.headline)
                .foregroundStyle(.white)
            
            Text("Sébastien DAGUIN Group s'engage à protéger votre jardin secret numérique. Contactez-nous pour toute précision.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))
                .padding(.horizontal, 30)
            
            Spacer(minLength: 40)
        }
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
