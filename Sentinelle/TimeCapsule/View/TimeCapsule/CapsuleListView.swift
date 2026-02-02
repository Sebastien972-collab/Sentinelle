//
//  CapsuleListView.swift
//  Sentinelle
//
//  Created by Sebby on 09/01/2025.
//

import SwiftUI
import SwiftData

struct CapsuleListView: View {
    enum Selection: String, CaseIterable {
        case all = "Toutes"
        case closed = "Scellées"
        case open = "Ouvertes"
    }
    
    @EnvironmentObject var capsuleManager: TimeCapsuleManager
    @Environment(\.modelContext) private var modelContext
    @State private var selection: Selection = .all
    
    // Filtrage optimisé
    var capsuleFilter: [TimeCapsule] {
        let sorted = capsuleManager.capsules.sorted { $0.openDate > $1.openDate }
        switch selection {
        case .all: return sorted
        case .open: return sorted.filter { $0.isOpened }
        case .closed: return sorted.filter { !$0.isOpened }
        }
    }
    
    var body: some View {
        ZStack {
            SunsetGradientView().ignoresSafeArea()
            VStack(spacing: 0) {
                Picker("Filtre", selection: $selection) {
                    ForEach(Selection.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(.ultraThinMaterial)
                
                if capsuleManager.capsules.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            ForEach(capsuleFilter) { capsule in
                                NavigationLink(destination: CapsuleDetailView(capsule: capsule)) {
                                    CapsuleCard(capsule: capsule)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("Mes Capsules")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: CapsulTimeView()) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
        .onAppear {
            capsuleManager.fetchCapsules(modelContext)
        }
    }
    
    // MARK: - Subviews
    
    private var emptyStateView: some View {
        ContentUnavailableView {
            Label("Aucune capsule", systemImage: "clock.arrow.2.circlepath")
        } description: {
            Text("Créez votre premier message pour le futur en appuyant sur le bouton +.")
        }
    }
}

// MARK: - Capsule Card (Composant Expert)
struct CapsuleCard: View {
    let capsule: TimeCapsule
    
    var body: some View {
        HStack(spacing: 15) {
            // Indicateur d'état visuel
            ZStack {
                Circle()
                    .fill(capsule.isOpened ? Color.green.opacity(0.2) : Color.indigo.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: capsule.isOpened ? "envelope.open.fill" : "lock.fill")
                    .foregroundColor(capsule.isOpened ? .green : .indigo)
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(capsule.isOpened ? "Capsule Ouverte" : "Prévue pour le")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
                
                Text(capsule.openDate, style: .date)
                    .font(.system(.body, design: .serif))
                    .fontWeight(.semibold)
                
                if !capsule.isOpened {
                    ProgressView(value: calculateProgress())
                        .tint(.indigo)
                        .scaleEffect(x: 1, y: 0.5, anchor: .center)
                        .padding(.top, 4)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.2), lineWidth: 0.5)
        )
    }
    
    // UX : Calcul du temps restant pour la barre de progression
    private func calculateProgress() -> Double {
        let now = Date().timeIntervalSince1970
        let creation = (capsule.openDate.addingTimeInterval(-31536000)).timeIntervalSince1970 // Simule 1 an
        let target = capsule.openDate.timeIntervalSince1970
        return max(0, min(1, (now - creation) / (target - creation)))
    }
}
#Preview {
    CapsuleListView()
        .environmentObject(TimeCapsuleManager.shared)
}
