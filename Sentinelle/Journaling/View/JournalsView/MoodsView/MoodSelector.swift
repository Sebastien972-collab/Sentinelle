//
//  MoodSelector.swift
//  Sentinelle
//
//  Created by Sebby on 04/11/2024.
//

import SwiftUI

struct MoodSelector: View {
    @Binding var mood: Mood
    @State private var selectedMood: MoodType = .neutral
    @Environment(\.presentationMode) var presentationMode // Pour fermer le popover
    
    var body: some View {
        //ScrollView(.horizontal, showsIndicators: false) {
        Picker("Mood", selection: $selectedMood) {
            ForEach(MoodType.allCases, id: \.self) { mood in
                    Text(Mood(type: mood).icon)
            }
        }
        .onChange(of: selectedMood, { oldValue, newValue in
            mood = Mood(type: newValue)
        })
        .pickerStyle(.palette)
        
        .padding()
        // }
    }
}

#Preview {
    MoodSelector(mood: .constant(.init(type: .angry)))
}
