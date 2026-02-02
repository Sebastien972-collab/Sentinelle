//
//  JournalsView.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import SwiftUI
import SwiftData

struct JournalsView: View {
    @StateObject private var journalManager: JournalManager = JournalManager()
    @Environment(\.modelContext) private var modelContext
    @Query private var journals: [Journal]
    @State private var popoverIsPresented: Bool = false
    @AppStorage("isAuthEnabled") private var authEnable: Bool = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @StateObject private var themeManager = AppearanceManager.shared
    @Namespace private var animationNamespace
    var searchResult: [Journal] {
        if searchText.isEmpty {
            return journals.sorted(by: { $0.date > $1.date })
            
        } else {
            return journals.filter { journal in
                journal.text.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces)) || journal.title.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces)) || journal.dailyMood.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces)) || journal.date.description.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces)) || Mood.getMood(journal.dailyMood).icon.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces))
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SunsetGradientView()
                if journals.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Text("\(searchResult.count) entrées")
                                .font(.system(size: 16, weight: .regular, design: .serif))
                                .fontWeight(.bold)
                                .padding(.bottom)
                            
                            ForEach(searchResult) { journal in
                                JournalRow(journal: journal, journalManager: journalManager)
                                    .padding(.bottom)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Mon Journal")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Rechercher un journal")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    PlusButtonView {
                        journalManager.managerIsPresented.toggle()
                    }
                    .navigationDestination(isPresented: $journalManager.managerIsPresented) {
                        NoteEditorView(journalManager: journalManager)
                            .navigationTransition(.zoom(sourceID: "plusButton", in: animationNamespace))
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    mainMenu
                }
            }
        }
    }
    private var mainMenu: some View {
        Menu {
            Section {
                NavigationLink(destination: StatisticsView(journals: journals)) {
                    Label("Tendances", systemImage: "chart.bar.xaxis")
                }
                NavigationLink(destination: CapsuleListView()) {
                    Label("Capsules temporelles", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                }
            }
            
            Menu {
                NavigationLink(destination: AppearanceSettingsView()) {
                    Label("Apparence de l'app", systemImage: "moonphase.first.quarter.inverse")
                }
                NavigationLink(destination: NotificationSettingsView()) {
                    Label("Notifications", systemImage: "bell.circle")
                }
                NavigationLink(destination: SecurityView()) {
                    Label("Sécurité et confidentialité", systemImage: "shield.fill")
                }
                NavigationLink(destination: AboutMeView()) {
                    Label("À propos", systemImage: "info.circle.fill")
                }
            } label: {
                Label("Réglages", systemImage: "gearshape") // Icône plus standard pour réglages
            }
        } label: {
            Image(systemName: "ellipsis.circle")
                .bold()
                .foregroundStyle(themeManager.currentTitleColor)
        }
    }

    private var emptyStateView: some View {
        VStack {
            Image(systemName: "pencil.and.scribble")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            Text("Appuyez sur le bouton '+' pour commencer votre premier journal.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding()
        }
    }
}

#Preview {
    JournalsView()
}
