//
//  LockView.swift
//  Sentinelle
//
//  Created by Sébastien DAGUIN on 02/02/2026.
//


import SwiftUI

struct LockView: View {
    @ObservedObject var authentication: LocalAuthenticationManager
    @State private var animateIcon: Bool = false
    
    // Couleur adaptative liquide
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.85)
    }

    var body: some View {
        ZStack {
            // Fond immersif (Sunset Gradient)
            SunsetGradientView()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // HEADER : SYMBOLE DE SÉCURITÉ
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.1))
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.white)
                            .symbolEffect(.bounce, value: animateIcon)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Accès Sécurisé")
                            .font(.system(.title, design: .serif, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text("Veuillez déverrouiller pour accéder à vos journaux.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                }
                
                Spacer()
                
                // BOUTON D'ACTION
                Button {
                    withAnimation {
                        animateIcon.toggle()
                        authentication.authenticate()
                    }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "faceid")
                            .font(.title2)
                        Text("Déverrouiller")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        LinearGradient(colors: [.blue, .blue.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                    )
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 40)
                
                // PETITE NOTE DE CONFIDENTIALITÉ
                Label("Vos données sont cryptées localement", systemImage: "checkmark.shield.fill")
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.bottom, 20)
            }
        }
        .onAppear {
            // Déclenchement automatique de l'auth à l'arrivée
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                authentication.authenticate()
            }
        }
        .alert(isPresented: $authentication.showError) {
            Alert(
                title: Text("Authentification"),
                message: Text(authentication.error?.localizedDescription ?? "Échec de la reconnaissance."),
                dismissButton: .default(Text("Réessayer")) {
                    authentication.authenticate()
                }
            )
        }
    }
}
