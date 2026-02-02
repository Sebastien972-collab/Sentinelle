//
//  LandingPageView.swift
//  Sentinelle
//
//  Created by Sebby on 05/12/2024.
//

import SwiftUI

struct LandingPageView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Pourquoi utiliser un journal d'émotions ?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                    
                    Text("Découvrez comment l'écriture peut transformer votre bien-être émotionnel.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Benefits Section
                VStack(alignment: .leading, spacing: 15) {
                    BenefitView(title: "Comprendre et explorer ses émotions", description: "Un journal d’émotions permet d'identifier clairement ce que vous ressentez au quotidien.", quote: "L'écriture est la peinture de la voix.", author: "Voltaire")
                    
                    BenefitView(title: "Réduire le stress et l'anxiété", description: "Prendre le temps de noter vos pensées et émotions peut vous aider à prendre du recul face à des situations stressantes.", quote: "Écrire est un moyen de parler sans être interrompu.", author: "Jules Renard")
                    
                    BenefitView(title: "Améliorer votre santé mentale", description: "En suivant régulièrement vos émotions, vous pouvez repérer des schémas ou tendances.", quote: "La santé mentale est une priorité, pas une option.", author: "")
                    
                    BenefitView(title: "Renforcer votre intelligence émotionnelle", description: "Être à l'écoute de vos émotions est essentiel pour développer votre intelligence émotionnelle.", quote: "Connais-toi toi-même.", author: "Socrate")
                    
                    BenefitView(title: "Favoriser la gratitude et les moments positifs", description: "Un journal d’émotions vous encourage à remarquer les aspects positifs de votre vie.", quote: "Ce n'est pas le bonheur qui nous rend reconnaissants, c'est la gratitude qui nous rend heureux.", author: "David Steindl-Rast")
                }
                .padding()
                
                // Call-to-Action Section
                VStack(spacing: 15) {
                    Text("Comment Sentinelle vous aide")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Enregistrer facilement vos émotions.")
                        Text("• Accéder à des suggestions et outils pour mieux gérer votre bien-être.")
                        Text("• Suivre votre évolution grâce à des visualisations et rapports personnalisés.")
                        Text("• Faire partie d'une communauté engagée dans l’amélioration du bien-être mental.")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Add action for starting the app
                        isPresented = false
                    }) {
                        Text("Commencez votre parcours dès aujourd'hui")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct BenefitView: View {
    let title: String
    let description: String
    let quote: String
    let author: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                Text("\"" + quote + "\"")
                    .italic()
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Spacer()
                Text(author)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    LandingPageView(isPresented: .constant(true))
}
