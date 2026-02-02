//
//  AppearanceManager.swift
//  Sentinelle
//
//  Created by Sebby on 16/12/2024.
//

import Foundation
import SwiftUI

enum Appearance: String, CaseIterable {
    case automatic = "Auto"
    case light = "Clair"
    case dark = "Sombre"
}
extension Appearance {
    var icon: String {
        switch self {
        case .automatic: return "circle.lefthalf.fill"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
}


class AppearanceManager: ObservableObject {
    static let shared = AppearanceManager() // Singleton
    private init() {
        // Initialiser avec la valeur sauvegardée
        updateAppearance()
    }
    @AppStorage("selectedAppearance") private var selectedAppearance: Appearance = .automatic
    @AppStorage("selectedAccentColor")  var selectedAccentColor: String = "Gray"
    @AppStorage("themeCustomEnable")  var themeCustomEnable: Bool = false
    var currentAccentColor: Color { accentColors[selectedAccentColor] ?? .silver }
    var currentPlusButtonColor: Color {
        guard themeCustomEnable else { return .gold }
        return accentColors[selectedAccentColor] ?? .metallicGold
    }
    var currentTitleColor: Color {
        guard themeCustomEnable else { return .secondary }
        return accentColors[selectedAccentColor] ?? .customWhite
    }
    let accentColors: [String: Color] = [
        "White": .customWhite, "Blue": .customBlue, "Red": .red, "Green": .green, "Orange": .orange,
        "Yellow": .yellow, "Pink": .pink, "Purple": .purple, "Cyan": .cyan,
        "Indigo": .indigo, "Brown": .brown, "Teal": .teal, "Gray": .silver, "Gold": .gold
    ]
    
    // Layout pour la grille
    
    
    
    func setAppearance(_ appearance: Appearance) {
        selectedAppearance = appearance
        updateAppearance()
    }
    
    func uptdateAccentColor(_ color: String) {
        if accentColors.keys.contains(color) {
            selectedAccentColor = color
        }
    }
    func resetAppearance() {
        selectedAccentColor = "White"
        selectedAppearance = .automatic
        updateAppearance()
    }
    func isSelected(_ appearance: Appearance) -> Bool {
        selectedAppearance == appearance
    }
    private func icon(for appearance: Appearance) -> String {
        switch appearance {
        case .automatic: return "circle.lefthalf.fill"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
    
    private func updateAppearance() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
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
