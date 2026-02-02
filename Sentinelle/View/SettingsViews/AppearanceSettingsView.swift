//
//  ApparenceSettingngView.swift
//  Sentinelle
//
//  Created by Sebby on 25/11/2024.
//

import SwiftUI


struct AppearanceSettingsView: View {
    @StateObject var manager: AppearanceManager = .shared
    let gridLayout = [GridItem(.adaptive(minimum: 40))]
    
    var body: some View {
        NavigationView {
            Form {
                // Section pour le mode d'apparence
                Section(header: Text("Mode d'apparence")) {
                    ForEach(Appearance.allCases, id: \.self) { appearance in
                        CustomButtonAppearanceView(appearance: appearance, manager: manager)
                    }
                }
                
                // Section pour les couleurs d'accentuation
                Section(header: Text("Couleur d'accentuation")) {
                    Toggle(isOn: $manager.themeCustomEnable) {
                        Text("Utiliser une couleur personnalisée")
                    }
                    .animation(.spring(), value: manager.themeCustomEnable)
                    if manager.themeCustomEnable {
                        LazyVGrid(columns: gridLayout, spacing: 15) {
                            ForEach(manager.accentColors.keys.sorted(), id: \.self) { colorName in
                                ZStack {
                                    Circle()
                                        .fill(manager.accentColors[colorName]!)
                                        .frame(width: 35, height: 35)
                                        .onTapGesture {
                                            withAnimation {
                                                manager.selectedAccentColor = colorName
                                            }
                                        }
                                    
                                    if manager.selectedAccentColor == colorName {
                                        Circle()
                                            .stroke(manager.accentColors[colorName] ?? Color.black, lineWidth: 2)
                                            .frame(width: 40, height: 40)
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            .navigationTitle("Apparence de l'application")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Custom view pour le choix de l'apparence
struct CustomButtonAppearanceView: View {
    let appearance: Appearance
    @ObservedObject var manager: AppearanceManager
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                manager.setAppearance(appearance)
            }
        } label: {
            HStack {
                Image(systemName: appearance.icon)
                    .foregroundColor(.primary)
                Text(appearance.rawValue)
                Spacer()
                ZStack {
                    Circle()
                        .stroke(lineWidth: 0.8)
                        .frame(width: 15, height: 15)
                    if manager.isSelected(appearance) {
                        Circle()
                            .fill()
                            .frame(width: 10, height: 10)
                    }
                }
            }
        }
    }
    
    
    
    
}

#Preview {
    AppearanceSettingsView()
}
