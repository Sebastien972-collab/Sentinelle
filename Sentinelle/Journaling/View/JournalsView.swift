//
//  JournalsView.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import SwiftUI
import SwiftData

struct JournalsView: View {
    // MARK: - Properties
    @StateObject private var journalManager: JournalManager = JournalManager()
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Journal.date, order: .reverse) private var journals: [Journal]
    @Namespace private var animationNamespace
    
    @State private var searchText: String = ""
    @StateObject private var themeManager = AppearanceManager.shared
    
    // Logique de recherche optimisée
    var searchResult: [Journal] {
        if searchText.isEmpty {
            return journals
        } else {
            let filtered = journals.filter { journal in
                journal.title.localizedCaseInsensitiveContains(searchText) ||
                journal.text.localizedCaseInsensitiveContains(searchText) ||
                journal.dailyMood.localizedCaseInsensitiveContains(searchText)
            }
            return filtered
        }
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // Fond immersif Liquid Glass
                SunsetGradientView()
                    .ignoresSafeArea()

                if journals.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 18) {
                            headerInfoView
                            ForEach(searchResult) { journal in
                                JournalRow(journal: journal, journalManager: journalManager)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 100)
                    }
                }
                
                // Bouton Plus Flottant (Zone de confort du pouce)
                plusButtonOverlay
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
            }
            .navigationTitle("Mon Journal")
            // Barre de recherche en haut, rétractable au scroll
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Rechercher dans mes pensées..."
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    mainMenu
                }
            }
        }
    }

    // MARK: - Subviews
    
    private var plusButtonOverlay: some View {
        PlusButtonView {
            journalManager.managerIsPresented.toggle()
        }
        .matchedGeometryEffect(id: "plusButton", in: animationNamespace)
        .navigationDestination(isPresented: $journalManager.managerIsPresented) {
            NoteEditorView(journalManager: journalManager)
                .navigationTransition(.zoom(sourceID: "plusButton", in: animationNamespace))
        }
    }

    private var headerInfoView: some View {
        HStack {
            Text("\(searchResult.count) \(searchResult.count > 1 ? "entrées" : "entrée")")
                .font(.system(.subheadline, design: .serif, weight: .bold))
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal, 4)
    }

    private var mainMenu: some View {
        Menu {
            // SECTION 1 : Valeur ajoutée et contenu
            Section {
                NavigationLink(destination: StatisticsView(journals: journals)) {
                    Label("Tendances", systemImage: "chart.bar.fill")
                }
                NavigationLink(destination: CapsuleListView()) {
                    Label("Capsules", systemImage: "leaf.fill") // Plus poétique pour le concept
                }
            }
            
            // SECTION 2 : Personnalisation et confort
            Section("Préférences") {
                NavigationLink(destination: AppearanceSettingsView()) {
                    Label("Apparence", systemImage: "paintbrush.fill")
                }
                NavigationLink(destination: NotificationSettingsView()) {
                    Label("Notifications", systemImage: "bell.badge.fill")
                }
            }
            
            // SECTION 3 : Sécurité et Légal (Moins fréquent)
            Section {
                NavigationLink(destination: SecurityView()) {
                    Label("Confidentialité", systemImage: "shield.checkered")
                }
                NavigationLink(destination: AboutMeView()) {
                    Label("À propos", systemImage: "info.circle")
                }
            }
        } label: {
            Image(systemName: "ellipsis.circle")
                .symbolRenderingMode(.hierarchical)
                .font(.title2)
                .foregroundStyle(themeManager.currentTitleColor)
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 15) {
            Image(systemName: "pencil.and.scribble")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            Text("Appuyez sur le bouton '+' pour commencer votre premier journal.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    JournalsView()
        .environmentObject(TimeCapsuleManager.shared)
}
