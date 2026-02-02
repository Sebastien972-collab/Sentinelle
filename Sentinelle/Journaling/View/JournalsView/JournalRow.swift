//
//  JournalRow.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import SwiftUI

struct JournalRow: View {
    var journal: Journal
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @State private var isEditing: Bool = false
    @State private var isExpanded: Bool = false
    @ObservedObject var journalManager: JournalManager
    @StateObject var manager: AppearanceManager = .shared

    var body: some View {
        VStack(spacing: 0) {
            // Media en haut (sans bordures pour un look immersif)
            JournalImagesView(journal: journal)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(8)

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(journal.title)
                        .font(.system(.headline, design: .serif))
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Text(Mood.getMood(journal.dailyMood).icon)
                        .font(.title3)
                }

                Text(journal.text)
                    .font(.system(.subheadline, design: .serif))
                    .lineLimit(isExpanded ? nil : 3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text(journal.date, style: .date)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.tertiary)
                    
                    Spacer()
                    
                    // Menu discret
                    Menu {
                        Button("Modifier", systemImage: "pencil") { isEditing.toggle() }
                        Button("Supprimer", systemImage: "trash", role: .destructive) {
                            deleteAction()
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(manager.currentAccentColor)
                            .padding(8)
                    }
                }
            }
            .padding([.horizontal, .bottom], 16)
        }
        .background(.ultraThinMaterial) // Look Liquid Glass
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.white.opacity(colorScheme == .dark ? 0.1 : 0.5), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                isExpanded.toggle()
            }
        }
        .navigationDestination(isPresented: $isEditing) {
            JournalEditorView(journalManager: journalManager, journal: journal)
        }
    }

    private func deleteAction() {
        withAnimation {
            journalManager.deleteJournal(journal, modelContext: modelContext)
        }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            SunsetGradientView()
            JournalRow(journal: .preview1, journalManager: JournalManager())
                .frame(maxHeight: 400)
                .padding()
            
        }
    }
}
