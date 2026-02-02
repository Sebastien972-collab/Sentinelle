//
//  NoteEditorView.swift
//  Sentinelle
//
//  Created by Sébastien DAGUIN on 15/01/2026.
//


import SwiftUI
import PhotosUI
#if canImport(JournalingSuggestions)
import JournalingSuggestions
#endif

struct NoteEditorView: View {
    @FocusState private var isInputActive: Bool
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var journalManager: JournalManager
    @Environment(\.dismiss) private var dismiss
    @State private var mood: Mood = .init(type: .neutral)
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImagesData = [Data]()
    @State private var moodViewIsPresented: Bool = false
    @FocusState private var focusedField: Field?
    enum Field {
        case title, text
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        TextField("Titre", text: $journalManager.journal.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .focused($focusedField, equals: .title)
                        if !selectedImagesData.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                layoutPhotos()
                            }
                            .frame(height: 110)
                        }
                        
                        // --- CHAMP TEXTE (COMPORTEMENT TEXTEDITOR) ---
                        TextField("Commencer à écrire...", text: $journalManager.journal.text, axis: .vertical)
                            .foregroundColor(.white)
                            .focused($focusedField, equals: .text)
                            .lineLimit(5...) // Hauteur minimale de 5 lignes
                    }
                    .padding()
                }
                
                // Barre d'outils flottante personnalisée
                customToolbar
            }
            .background(Color(uiColor: .systemBackground).edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        Button(action: {
                            journalManager.journal.dailyMood = mood.type.rawValue
                            journalManager.updateJournals(modelContext: modelContext)
                            dismiss()
                        }) {
                            Image(systemName: "arrow.uturn.backward")
                        }
                        
                        Button(action: {
                            journalManager.addToJournal(modelContext: modelContext)
                            dismiss()
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .blue)
                                .font(.title3)
                        }
                    }
                    .foregroundColor(.gray)
                }
            }
            .transition(.opacity.combined(with: .move(edge: .bottom)))
            .toolbarRole(.editor)
        }
        
    }
    
    // --- SOUS-VUES ---
    
    private var customToolbar: some View {
        HStack(spacing: 25) {
            Group {
#if canImport(JournalingSuggestions)
                JournalingSuggestionsPicker {
                    Image(systemName: "sparkles")
                } onCompletion: { suggestion in
                    self.journalManager.journal = await Journal.convertSuggestionToJournal(suggestion)
                }
#endif
                PhotosPicker(selection: $selectedItems,
                             maxSelectionCount: 10,
                             matching: .images) {
                    Image(systemName: "photo")
                }
                             .onChange(of: selectedItems) {
                                 loadSelectedItems()
                             }
                
                Button(action: {}) { Image(systemName: "camera") }
                Button(action: {}) { Image(systemName: "waveform") }
                Button(action: {}) {
                    Image(systemName: "paperplane.fill").rotationEffect(.degrees(45))
                }
                Button {
                    moodViewIsPresented.toggle()
                } label: {
                    Text(mood.icon)
                }

            }
            .font(.system(size: 20))
            .foregroundColor(.primary)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 25)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 5)
        )
        .padding(.bottom, 10)
        .sheet(isPresented: $moodViewIsPresented) {
            MoodSelector(mood: $mood)
        }
    }
    
    @ViewBuilder
    private func layoutPhotos() -> some View {
        HStack(spacing: 12) {
            ForEach(selectedImagesData, id: \.self) { data in
                if let uiImage = UIImage(data: data) {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        // Bouton pour supprimer une photo
                        Button(action: { removePhoto(data: data) }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.white, .black.opacity(0.7))
                        }
                        .padding(4)
                    }
                }
            }
        }
    }
    
    // --- LOGIQUE ---
    
    private func loadSelectedItems() {
        Task {
            // Pour cet exemple, on recrée la liste, mais on pourrait aussi ajouter les nouvelles
            var newImages = [Data]()
            for item in selectedItems {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    newImages.append(data)
                }
            }
            await MainActor.run {
                self.selectedImagesData = newImages
            }
        }
    }
    
    private func removePhoto(data: Data) {
        if let index = selectedImagesData.firstIndex(of: data) {
            selectedImagesData.remove(at: index)
            // On retire aussi de selectedItems pour garder la synchro avec le Picker
            if index < selectedItems.count {
                selectedItems.remove(at: index)
            }
        }
    }
}

#Preview {
    NoteEditorView(journalManager: .init())
}
