//
//  AboutMeView.swift
//  Sentinelle
//
//  Created by Sebby on 05/12/2024.
//

import SwiftUI

struct AboutMeView: View {
    // Couleur adaptative liquide
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.8)
    }
    
    var body: some View {
        ZStack {
            // Fond immersif
            SunsetGradientView().ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    // HEADER : PROFIL
                    VStack(spacing: 15) {
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.2))
                                .frame(width: 160, height: 160)
                            
                            Image("monLogo") // Assure-toi que l'image est bien dans tes Assets
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(.white, lineWidth: 3))
                                .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 10)
                        }
                        
                        Text("Sébastien")
                            .font(.system(.title, design: .serif, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text("Développeur iOS & Créateur de Sentinelle")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .padding(.top, 20)

                    // SECTION : HISTOIRE
                    VStack(alignment: .leading, spacing: 15) {
                        aboutSectionCard(
                            title: "Mon Histoire",
                            icon: "person.fill",
                            text: "Passionné par l'écosystème iOS, j'ai conçu cette application pour offrir un outil intuitif dédié au bien-être. Mon objectif est de simplifier la surveillance de votre état mental au quotidien."
                        )
                        
                        aboutSectionCard(
                            title: "Mission de l'application",
                            icon: "heart.text.square.fill",
                            text: "Sentinelle vous permet d'analyser vos émotions et de découvrir des ressources pour votre équilibre. C'est une plateforme conçue par la communauté, pour la communauté, plaçant l'humain au centre de chaque ligne de code."
                        )
                    }

                    // SECTION : ACTIONS
                    VStack(spacing: 15) {
                        NavigationLink {
                            SupportUsView()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.up.heart.fill")
                                Text("Soutenir le projet")
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        }

                        Link(destination: URL(string: "https://sebastiendaguin.com")!) {
                            HStack {
                                Image(systemName: "globe")
                                Text("Visiter mon portfolio")
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white.opacity(0.2), lineWidth: 1))
                        }
                    }
                    .padding(.horizontal, 5)

                    Text("Version 1.0 • Fait avec ❤️")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.bottom, 20)
                }
                .padding(25)
            }
        }
        .navigationTitle("À propos")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helper View
    private func aboutSectionCard(title: String, icon: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            Text(text)
                .font(.system(.body, design: .serif))
                .lineSpacing(4)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    NavigationStack {
        AboutMeView()
    }
}
