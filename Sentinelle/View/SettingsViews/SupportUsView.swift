//
//  SupportUsView.swift
//  Sentinelle
//
//  Created by Sebby on 05/12/2024.
//

import SwiftUI

struct SupportUsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Titre principal
                Text("Nous soutenir")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Description
                Text("Aidez-nous à continuer de développer Sentinelle et à offrir des outils pour le bien-être mental. Voici comment vous pouvez nous soutenir :")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Bouton pour laisser un avis
                SupportButton(
                    title: "Laissez un avis sur l'App Store",
                    icon: "star.fill",
                    action: {
                        if let url = URL(string: "https://apps.apple.com/fr/app/noctis/id6738321615") {
                            UIApplication.shared.open(url)
                        }
                    }
                )
                ShareLink(item: URL(string: "https://apps.apple.com/fr/app/noctis/id6738321615")!) {
                    Label("Partagez Noctis avec vos proches", systemImage: "square.and.arrow.up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                ShareLink(item: URL(string: "https://testflight.apple.com/join/G1kX1pyC")!) {
                    Label("Tester les fonctionnalitées de Noctis avant tout le monde.", systemImage: "square.and.arrow.up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
//                NavigationLink {
//                    SafariView(url: "https://checkout.revolut.com/pay/95983ce2-c741-4e06-a053-b4904cf79ff2")
//                } label: {
//                    Label("Faire un don", systemImage: "heart.fill")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 20)
//                }

                
                Spacer()
            }
            .padding()
        }
    }
}


// Composant réutilisable pour un bouton
struct SupportButton: View {
    var title: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
    }
}
#Preview {
    SupportUsView()
}
