//
//  AppearanceSettingsView.swift
//  Sentinelle
//
//  Created by Sebby on 25/11/2024.
//

import SwiftUI

struct AppearanceSettingsView: View {
    // MARK: - Properties
    @StateObject var manager: AppearanceManager = .shared
    @Namespace private var animationNamespace
    
    let gridLayout = [GridItem(.adaptive(minimum: 45), spacing: 20)]
    
    var body: some View {
        ZStack {
            // Fond immersif Liquid Glass (Cohérence avec JournalsView)
            SunsetGradientView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // SECTION 1 : MODE D'APPARENCE (Sélecteur visuel)
                    VStack(alignment: .leading, spacing: 15) {
                        Label("Style visuel", systemImage: "sun.max.fill")
                            .font(.system(.headline, design: .serif))
                            .foregroundStyle(.white)
                            .padding(.leading, 5)
                        
                        HStack(spacing: 12) {
                            ForEach(Appearance.allCases, id: \.self) { appearance in
                                appearanceOption(for: appearance)
                            }
                        }
                    }
                    
                    // SECTION 2 : COULEURS D'ACCENTUATION
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Label("Couleur d'accentuation", systemImage: "paintpalette.fill")
                                .font(.system(.headline, design: .serif))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Toggle("", isOn: $manager.themeCustomEnable)
                                .labelsHidden()
                                .tint(manager.currentAccentColor)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        if manager.themeCustomEnable {
                            colorPickerGrid
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }
                    
                    // SECTION 3 : APERÇU DYNAMIQUE
                    previewSection
                }
                .padding(20)
            }
        }
        .navigationTitle("Apparence")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private func appearanceOption(for appearance: Appearance) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                manager.setAppearance(appearance)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        } label: {
            VStack(spacing: 12) {
                Image(systemName: appearance.icon)
                    .font(.title2)
                Text(appearance.rawValue)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(manager.isSelected(appearance) ? .white.opacity(0.25) : .secondary.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(manager.isSelected(appearance) ? .white : .white.opacity(0.1), lineWidth: 1.5)
            )
            .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }

    private var colorPickerGrid: some View {
        LazyVGrid(columns: gridLayout, spacing: 20) {
            ForEach(manager.accentColors.keys.sorted(), id: \.self) { colorName in
                let color = manager.accentColors[colorName]!
                
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 42, height: 42)
                        .shadow(color: color.opacity(0.4), radius: 6, x: 0, y: 3)
                    
                    if manager.selectedAccentColor == colorName {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                            .frame(width: 54, height: 54)
                            .matchedGeometryEffect(id: "accentCircle", in: animationNamespace)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        manager.selectedAccentColor = colorName
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Aperçu du thème")
                .font(.caption)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundStyle(.white.opacity(0.6))
                .padding(.leading, 5)
            
            HStack(spacing: 15) {
                Circle()
                    .fill(manager.currentAccentColor)
                    .frame(width: 12, height: 12)
                
                VStack(alignment: .leading) {
                    Text("Ma pensée du jour")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("Le design est l'ambassadeur silencieux de votre marque.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                }
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundStyle(manager.currentAccentColor)
            }
            .padding(16)
            .background(.black.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AppearanceSettingsView()
    }
}
