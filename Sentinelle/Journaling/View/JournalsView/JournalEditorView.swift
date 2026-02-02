//
//  JournalEditorView.swift
//  Sentinelle
//
//  Created by Sebby on 03/11/2024.
//

import SwiftUI
import PhotosUI

struct JournalEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var journalManager: JournalManager
    @State private var mood: Mood = .init(type: .neutral)
    @FocusState private var isFocused: Field?
    @State private var selectedItems = [PhotosPickerItem]()
    @State var journal: Journal = Journal(date: Date(), title: "", text: "", dailyMood: .neutral)
    @Environment(\.dismiss) private var dismiss
    @State private var showDatePicker: Bool = false
    enum Field {
        case title, text, none
    }
    
    var body: some View {
        NavigationStack {
            NoteEditorView(journalManager: journalManager)
            .onTapGesture {
                isFocused = nil
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

#Preview {
    NavigationStack {
        JournalEditorView(journalManager: JournalManager(), journal: .preview1)
    }
}
