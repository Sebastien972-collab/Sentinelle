import Foundation
import SwiftUI

enum MoodType: String, CaseIterable, Hashable, Codable {
    case jubilant = "Très heureux"
    case happy = "Heureux"
    case motivated = "Motivé"
    case calm = "Calme"
    case neutral = "Neutre"
    case stressed = "Stressé"
    case sad = "Triste"
    case depressed = "Déprimé"
    case angry = "Énervé"
    case tired = "Fatigué"
    case confused = "Confus"
    
    // Accès rapide au modèle Mood
    var info: Mood {
        Mood(type: self)
    }
}

struct Mood: Hashable, Equatable {
    let type: MoodType
    
    // Propriétés calculées (Plus propre et performant que l'init manuel)
    var icon: String {
        switch type {
        case .jubilant: return "🌞"
        case .happy:    return "🌿"
        case .motivated: return "🔥"
        case .calm:     return "🌊"
        case .neutral:  return "😐"
        case .stressed: return "⚡️"
        case .sad:      return "🌧️"
        case .depressed: return "💧"
        case .angry:    return "💢"
        case .tired:    return "😴"
        case .confused: return "❓"
        }
    }
    
    // Gradient Liquid Glass pour chaque Mood
    var gradient: LinearGradient {
        let colors: [Color] = {
            switch type {
            case .jubilant:  return [.yellow, .orange]
            case .happy:     return [.green, .mint]
            case .motivated: return [.orange, .red]
            case .calm:      return [.blue, .cyan]
            case .neutral:   return [.gray, .secondary]
            case .stressed:  return [.purple, .orange]
            case .sad:       return [.blue, .indigo]
            case .depressed: return [.indigo, .black]
            case .angry:     return [.red, .black]
            case .tired:     return [.gray, .blue.opacity(0.3)]
            case .confused:  return [.purple, .indigo]
            }
        }()
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    // Couleur principale (fallback)
    var color: Color {
        switch type {
        case .jubilant: return .yellow
        case .motivated: return .orange
        case .calm: return .blue
        case .angry: return .red
        case .happy: return .green
        default: return .secondary
        }
    }

    // Recherche de Mood optimisée
    static func getMood(_ rawValue: String) -> Mood {
        let type = MoodType.allCases.first { $0.rawValue == rawValue } ?? .neutral
        return Mood(type: type)
    }
}

// Modèle pour les graphiques (Charts)
struct MoodFrequency: Identifiable, Equatable {
    let id = UUID()
    let moodType: MoodType
    let frequency: Int // Utiliser Int pour des comptes réels d'entrées
    
    // Pour l'affichage dans les graphiques
    var label: String { moodType.rawValue }
    var icon: String { moodType.info.icon }
}
