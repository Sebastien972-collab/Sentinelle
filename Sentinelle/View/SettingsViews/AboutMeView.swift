//
//  AboutMeView.swift
//  Sentinelle
//
//  Created by Sebby on 05/12/2024.
//

import SwiftUI

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Titre de la section
                Text("À propos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Image de profil
                Image("monLogo") // Remplacez par votre image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.top, 20)

                // Description
                Text("Je suis Sébastien, développeur iOS passionné. J'ai créé **Noctis** dans l'objectif d'offrir un outil accessible et intuitif pour améliorer la qualité de vie et le bien-être de chacun.")
                    .font(.body)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)

                // Mission de l'application
                Text("Mission de Noctis")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.top, 30)
                
                Text("**Noctis** a pour but de permettre aux utilisateurs de surveiller leur humeur, d'analyser leur état mental et de découvrir des ressources pour améliorer leur bien-être. En offrant une plateforme simple et sécurisée, nous espérons aider nos utilisateurs à mieux comprendre leur état émotionnel et à prendre des décisions pour leur bien-être. Sentinelle se positionne comme une plateforme communautaire conçue pour sa communauté, pour sa communauté.")
                    .font(.body)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)

                // Lien vers le site web ou d'autres plateformes
                VStack {
                    NavigationLink {
                        SupportUsView()
                    } label: {
                        Label("Nous supporter", systemImage: "arrow.up.heart")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    }
                    .padding(.horizontal, 20)
//                    NavigationLink {
//                        SafariView(url: "https://sebastiendaguin.com")
//                    } label: {
//                        Text("Visitez mon site")
//                            .foregroundColor(.blue)
//                            .fontWeight(.semibold)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
//                    }
//                    .padding(.horizontal, 20)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AboutMeView()
}
