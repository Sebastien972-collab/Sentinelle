//
//  SettingsListView.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import SwiftUI

struct SecurityView: View {
    @AppStorage("isAuthEnabled") private var authEnable: Bool = false
    @AppStorage("digitalPasswordEnabled") private var digitPassEnable: Bool = false
    private let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var body: some View {
        List {
            Section {
                Toggle(isOn: $authEnable) {
                    Label("Activer l'authentification", systemImage: "faceid")
                }
                .animation(.easeIn(duration: 0.6), value: authEnable)
                Toggle(isOn: .constant(false)) {
                    HStack {
                        Label("Mot de passe", systemImage: "lock")
                        Text("Désactivé")
                            .foregroundStyle(.secondary)
                    }
                }
                .animation(.easeInOut(duration: 0.6), value: digitPassEnable)
            } header: {
                Text("Authentification")
            }
            
            Section {
                HStack {
                    Text("Version")
                    Text(version ?? "Inconnue")
                }
                NavigationLink {
                    PrivacyPolicyView()
                } label: {
                    Text("Confidentialité")
                        .foregroundStyle(.blue)
                }

            } header: {
                Text("A propos de l'app")
            }

        }
        .navigationTitle("Sécurité de l'app")
    }
}

#Preview {
    NavigationStack {
        SecurityView()
    }
}
