//
//  MoodSelector.swift
//  Sentinelle
//
//  Created by Sebby on 04/11/2024.
//

import SwiftUI

struct MoodSelector: View {
    @Binding var mood: Mood
    @Environment(\.dismiss) var dismiss // Permet de fermer la vue
    @Environment(\.colorScheme) var colorScheme
    
    // Couleur adaptative liquide
    private var cardColor: Color {
        Color(uiColor: .systemBackground).opacity(0.85)
    }

    var body: some View {
        VStack(spacing: 0) {
            // BARRE SUPÉRIEURE : BOUTON FERMER
            HStack {
                Spacer()
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary.opacity(0.5))
                        .symbolRenderingMode(.hierarchical)
                }
                .buttonStyle(.plain)
                .padding([.top, .trailing], 16)
            }

            VStack(spacing: 20) {
                // Label de question
                VStack(spacing: 4) {
                    Text("Comment vous sentez-vous ?")
                        .font(.system(.headline, design: .serif))
                        .foregroundStyle(.primary)
                    
                    Text(mood.type.rawValue)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(mood.color)
                        .textCase(.uppercase)
                }

                // ScrollView horizontale
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 15) {
                            ForEach(MoodType.allCases, id: \.self) { type in
                                moodButton(for: type)
                                    .id(type)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .onAppear {
                            proxy.scrollTo(mood.type, anchor: .center)
                        }
                    }
                }
            }
            .padding(.bottom, 25)
        }
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
    }

    @ViewBuilder
    private func moodButton(for type: MoodType) -> some View {
        let isSelected = mood.type == type
        let info = type.info
        
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                mood = info
            }
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } label: {
            VStack(spacing: 12) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(info.gradient.opacity(0.2))
                            .frame(width: 55, height: 55)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    Text(info.icon)
                        .font(.system(size: isSelected ? 38 : 30))
                }
                .frame(width: 60, height: 60)
                
                Circle()
                    .fill(isSelected ? info.color : .clear)
                    .frame(width: 6, height: 6)
            }
            .scaleEffect(isSelected ? 1.1 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        SunsetGradientView().ignoresSafeArea()
        VStack {
            Spacer()
            MoodSelector(mood: .constant(Mood(type: .neutral)))
                .padding()
        }
    }
}
