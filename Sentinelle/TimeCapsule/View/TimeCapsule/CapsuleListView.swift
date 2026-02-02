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
        case open = "Ouvertes"
        case closed = "Verouillée"
    }
    @EnvironmentObject var capsuleManager: TimeCapsuleManager
    @Environment(\.modelContext) private var modelContext
    
    @State var selection: Selection = .all
    var capsuleFilter: [TimeCapsule] {
        switch selection {
        case .all: return capsuleManager.capsules.sorted { $0.openDate > $1.openDate }
        case .open: return capsuleManager.capsules.filter { $0.isOpened }
        case .closed: return capsuleManager.capsules.filter { Date.now <= $0.openDate }
        }
    }
    var body: some View {
        
            VStack {
                if capsuleManager.capsules.isEmpty {
                    Text("Aucune capsule n'a encore été créée.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List {
                        ForEach(capsuleFilter) { capsule in
                            NavigationLink(destination: CapsuleDetailView(capsule: capsule)) {
                                CapsuleRowView(capsule: capsule)
                            }
                        }
                        .onDelete(perform: deleteCapsules)
                    }
                }
            }
            .navigationTitle("Mes Capsules")
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: CapsulTimeView()) {
//                        Image(systemName: "plus")
//                            .foregroundColor(.blue)
//                    }
//                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(Selection.allCases, id: \.self) { selection in
                            Button {
                                self.selection = selection
                            } label: {
                                HStack {
                                    Text(selection.rawValue)
                                    if self.selection == selection {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }

                        }
                    } label: {
                        Image(systemName: "line.2.horizontal.decrease.circle")
                    }

                }
            }
            .onAppear {
                capsuleManager.fetchCapsules(modelContext)
            }
        }

    private func deleteCapsules(at offsets: IndexSet) {
        for index in offsets {
            let capsule = capsuleManager.capsules[index]
            capsuleManager.deleteCapsule(capsule, modelContext: modelContext)
        }
    }
}
#Preview {
    CapsuleListView()
        .environmentObject(TimeCapsuleManager.shared) // Inj
}
