//
//  Mood.swift
//  Sentinelle
//
//  Created by Sebby on 04/11/2024.
//

import Foundation
import SwiftUI

enum MoodType: String, CaseIterable, Hashable, Codable {
    case jubilant = "Très heureux"
    case happy = "Heureux"
    case motivated = "Motivé"
    case calm = "Calme"
    case neutral = "Neutre"
    case stressed = "Stressant"
    case sad = "Triste"
    case depressed = "Déprimé"
    case angry = "Énervé"
    case tired = "Fatigué"
    case confused = "Confus"
    
    func getMood() -> Mood {
        Mood(type: self)
    }
}
struct Mood: Hashable, Equatable {
    var type: MoodType
    //let intensity: Int  // Échelle de 1 à 5, 5 étant l'intensité maximale.
    var icon: String
    var color: Color
    
    init(type: MoodType) {
        self.type = type
       // self.intensity = intensity
        
        // Définir l’icône et la couleur en fonction du type d'humeur
        switch type {
        case .jubilant:
            icon = "🌞"
            color = .yellow
        case .happy:
            icon = "🌿"
            color = .green
        case .motivated:
            icon = "🔥"
            color = .orange
        case .calm:
            icon = "🌊"
            color = .blue
        case .stressed:
            icon = "⚡"
            color = .orange
        case .sad:
            icon = "🌧"
            color = .blue.opacity(0.6)
        case .depressed:
            icon = "💧"
            color = .blue.opacity(0.8)
        case .angry:
            icon = "😡"
            color = .red
        case .tired:
            icon = "😴"
            color = .gray
        case .confused:
            icon = "❓"
            color = .purple
        case .neutral:
            icon = "😐"
            color = .secondary
        }
    }
    
    static func getMood(_ moodToGet: String) -> Mood {
        for mood in MoodType.allCases  {
            if moodToGet == mood.rawValue {
                return Mood(type: mood)
            }
        }
        return Mood(type: .neutral)
    }
}

struct MoodFrequency: Identifiable , Equatable{
    let id = UUID()
    let mood: MoodType
    let frequency: Double
    
    
}
