//
//  JournalRow.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import SwiftUI

struct JournalRow: View {
    var journal: Journal
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var modelContext
    @State private var isEditing: Bool = false
    @State private var isExpanded: Bool = false
    @ObservedObject var journalManager: JournalManager
    @StateObject var manager: AppearanceManager = .shared
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            JournalImagesView(journal: journal)
            VStack(alignment: .leading) {
                Spacer()
                if !journal.text.isEmpty || !journal.title.isEmpty {
                    Text(journal.title)
                        .font(.system(size: 17, weight: .regular, design: .serif))
                        .fontWeight(.bold)
                        .padding(.vertical, 3)
                    Text(journal.text)
                        .lineLimit(isExpanded ? nil : 3)
                        .font(.system(size: 17, weight: .regular, design: .serif))
                        .fontWeight(.regular)
                        .truncationMode(.tail)
                }
                Divider()
                HStack {
                    Text(journal.date, style: .date)
                        .environment(\.locale, Locale(identifier: "fr_FR"))
                        .font(.system(size: 17, weight: .regular, design: .serif))
                        .fontWeight(.ultraLight)
                        .foregroundStyle(.secondary)
//                    Text(journal.date.formatted(.relative(presentation: .named)))
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
                    Text(Mood.getMood(journal.dailyMood).icon)
                    
                    Spacer()
                    Menu("", systemImage: "ellipsis.circle") {
                        Button("Modifier", systemImage: "pencil", action: { isEditing.toggle() })
                        Section {
                            Button("Supprimer", systemImage: "trash", role: .destructive, action: {
                                withAnimation(.easeInOut(duration: 0.7)) {
                                    DispatchQueue.main.async {
                                        journalManager.deleteJournal(journal, modelContext: self.modelContext)
                                    }
                                }
                            })
                        }
                    }
                    .foregroundStyle(manager.currentAccentColor)
                }
            }
            .font(.system(size: 24, weight: .regular, design: .serif))
            .padding(.horizontal)
            .padding(.bottom, 3)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isExpanded.toggle()
                }
            }
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 10.5)
                .fill(
                    colorScheme == .dark ? LinearGradient(colors: [Color.black,
                                                                   Color.black.opacity(0.55),
                                                                  ], startPoint: .top, endPoint: .bottomTrailing)
                    : LinearGradient(colors: [Color.white,
                                             ], startPoint: .top, endPoint: .bottomTrailing)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10.5)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
        })
        .frame(maxWidth: .infinity)
        .navigationDestination(isPresented: $isEditing, destination: {
            JournalEditorView(journalManager: journalManager, journal: journal)
        })
        .contextMenu {
            Button("Supprimer", systemImage: "trash", role: .destructive, action: {
                withAnimation(.easeInOut(duration: 0.7)) {
                    journalManager.deleteJournal(journal, modelContext: self.modelContext)
                }
            })
        }
        .clipped()
        
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
