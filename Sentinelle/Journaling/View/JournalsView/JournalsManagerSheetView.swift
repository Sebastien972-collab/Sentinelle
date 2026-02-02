//
//  JournalsManagerSheetView.swift
//  Sentinelle
//
//  Created by Sebby on 03/11/2024.
//

import SwiftUI
#if canImport(JournalingSuggestions)
import JournalingSuggestions
#endif

struct JournalsManagerSheetView: View {
    @ObservedObject var journalsManager: JournalManager
    @State private var journal = Journal.preview1
    @State var suggestionContent = [UIImage]()
    @State var launchEditorWithSuggestion: Bool = false
    let buttonTitle = "Montrer mes événements personnels"

    var body: some View {
        NavigationStack {
            ZStack {
                SunsetGradientView()
                VStack {
                    AddJournalButtonView(title: "Ajouter au journal", systemImageName: "square.and.pencil") {
                        journalsManager.isEditing.toggle()
                    }
                    .navigationDestination(isPresented: $journalsManager.isEditing) {
                        JournalEditorView(journalManager: journalsManager)
                    }
#if canImport(JournalingSuggestions)
                    JournalingSuggestionsPicker {
                        Label(buttonTitle, systemImage:"wand.and.sparkles")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.suggestionPurple
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            )
                            .padding()
                    } onCompletion: { suggestion in
                        self.journal = await Journal.convertSuggestionToJournal(suggestion)
                        launchEditorWithSuggestion.toggle()
                    }
                    .navigationDestination(isPresented: $launchEditorWithSuggestion) {
                        JournalEditorView(journalManager: journalsManager, journal: journal )
                    }
#endif
                    Spacer()
                    CapsuleTimeButton()
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Annuler") {
                            journalsManager.managerIsPresented.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    JournalsManagerSheetView(journalsManager: .preview)
}


struct AddJournalButtonView: View {
    let title: String
    let systemImageName: String?
    var action: () -> Void
    var body: some View {
        Button {
            NotificationManager.triggerImpactFeedback()
            action()
        } label: {
            Label(title, systemImage: systemImageName ?? "")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                )
        }
        .padding()
    }
}
