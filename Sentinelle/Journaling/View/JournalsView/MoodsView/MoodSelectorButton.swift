//
//  MoodSelectorButton.swift
//  Sentinelle
//
//  Created by Sebby on 04/11/2024.
//

import SwiftUI

struct MoodSelectorButton: View {
    @Binding var selectedMood: Mood
    @State var isPressed: Bool = false
    var body: some View {
        Button {
            isPressed.toggle()
        } label: {
            Text(selectedMood.icon)
                .clipShape(Circle())
        }
//        .sheet(isPresented: $isPressed) {
//            MoodSelector(selectedMood: $selectedMood)
//        }
        

    }
               
}

#Preview {
    @Previewable @State var selectedMood: Mood = .init(type: .happy)
    MoodSelectorButton(selectedMood: $selectedMood)
}
