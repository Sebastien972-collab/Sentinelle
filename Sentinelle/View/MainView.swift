//
//  ContentView.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var isUnloked: Bool = false
    @State private var authenticationError: String?
    @StateObject private var authentication: LocalAuthenticationManager = LocalAuthenticationManager()
    @StateObject private var capsuleManager = TimeCapsuleManager.shared
    @AppStorage("selectedAppearance") private var selectedAppearance: Appearance = .automatic
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    var body: some View {
        switch authentication.authenticationState {
        case .loggedOut:
            VStack {
                Text("Veuillez déverrouiller l'application")
                    .font(.headline)
                    .padding()
                
                Button("Déverrouiller avec Face ID") {
                    authentication.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .onAppear {
                updateAppearance()
                authentication.authenticate()
            }
            .alert(isPresented: $authentication.showError) {
                Alert(title: Text("Erreur d'authentification"), message: Text(authentication.error?.localizedDescription ?? "Erreur inconnue"), dismissButton: .default(Text("OK")))
            }
        case .loggedIn:
            if isFirstLaunch {
                LandingPageView(isPresented: $isFirstLaunch)
            } else {
                JournalsView()
                    .environmentObject(capsuleManager)
            }
        }
    }
    private func updateAppearance() {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }
            
            switch selectedAppearance {
            case .light:
                window.overrideUserInterfaceStyle = .light
            case .dark:
                window.overrideUserInterfaceStyle = .dark
            default:
                window.overrideUserInterfaceStyle = .unspecified
            }
        }
}

#Preview {
    @Previewable @StateObject var capsuleManager = TimeCapsuleManager.shared
    MainView()
        .environmentObject(capsuleManager)
}
