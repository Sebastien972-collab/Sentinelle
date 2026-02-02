//
//  LandingPageView.swift
//  Sentinelle
//
//  Created by Sebby on 05/12/2024.
//

import SwiftUI

struct LandingPageView: View {
    @Binding var isPresented: Bool
    
    // On utilise une couleur adaptative pour le look Liquid Glass
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.8)
    }
    
    var body: some View {
        ZStack {
            // Fond immersif
            SunsetGradientView().ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    // HEADER : ACCROCHE ÉMOTIONNELLE
                    VStack(spacing: 12) {
                        Text("Pourquoi utiliser un journal d'émotions ?")
                            .font(.system(.largeTitle, design: .serif, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        Text("Découvrez comment l'écriture peut transformer votre bien-être émotionnel.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 40)
                    
                    // SECTION : BÉNÉFICES (Cartes Expert)
                    VStack(spacing: 16) {
                        BenefitCard(
                            icon: "brain.head.profile",
                            title: "Explorer ses émotions",
                            description: "Identifiez clairement vos schémas de pensée au quotidien.",
                            quote: "L'écriture est la peinture de la voix.",
                            author: "Voltaire"
                        )
                        
                        BenefitCard(
                            icon: "leaf.fill",
                            title: "Réduire le stress",
                            description: "Prendre du recul face aux situations stressantes par les mots.",
                            quote: "Écrire est un moyen de parler sans être interrompu.",
                            author: "Jules Renard"
                        )
                        
                        BenefitCard(
                            icon: "sparkles",
                            title: "Cultiver la gratitude",
                            description: "Remarquez les aspects positifs qui illuminent vos journées.",
                            quote: "La gratitude rend heureux.",
                            author: "David Steindl-Rast"
                        )
                    }
                    .padding(.horizontal)
                    
                    // SECTION : FONCTIONNALITÉS SENTINELLE
                    VStack(spacing: 20) {
                        Text("L'approche Sentinelle")
                            .font(.system(.title2, design: .serif, weight: .bold))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            FeatureRow(icon: "bolt.fill", text: "Enregistrement ultra-rapide des émotions.")
                            FeatureRow(icon: "chart.pie.fill", text: "Visualisations et rapports personnalisés.")
                            FeatureRow(icon: "person.2.fill", text: "Une communauté bienveillante et engagée.")
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)
                    
                    // CTA : BOUTON D'ACTION
                    Button(action: {
                        withAnimation { isPresented = false }
                    }) {
                        Text("Commencer mon parcours")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .clipShape(Capsule())
                            .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 50)
                }
            }
        }
    }
}

// MARK: - Subviews

struct BenefitCard: View {
    let icon: String
    let title: String
    let description: String
    let quote: String
    let author: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.blue)
                Text(title)
                    .font(.headline)
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\"\(quote)\"")
                    .font(.system(.caption, design: .serif))
                    .italic()
                    .foregroundStyle(.blue.opacity(0.8))
                
                Text("— \(author)")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 5)
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground).opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.2), lineWidth: 0.5)
        )
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.purple)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
        }
    }
}

#Preview {
    LandingPageView(isPresented: .constant(true))
}
