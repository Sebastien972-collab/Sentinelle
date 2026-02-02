//
//  JournalManager.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import Foundation
import SwiftData

class JournalManager: ObservableObject {
    @Published var isEditing: Bool = false
    @Published var selectedDate = Date()
    @Published var mood: Mood = .init(type: .neutral)
    @Published var journals: [Journal] = []
    @Published var managerIsPresented: Bool = false
    @Published var imageData: [Data] = []
    var journal: Journal = Journal(date: Date(), title: "", text: "", dailyMood: .neutral)
    
    @Published var showError: Bool = false
    @Published var error: Error = JournalError.uknown
    
    func addToJournal(modelContext: ModelContext) {
        guard !journal.text.isEmpty  else {
            error = JournalError.fieldIsEmpty
            return showError.toggle()
        }
        
        let newJournalEntry = journal
        for data in imageData {
            newJournalEntry.imageData.append(data)
        }
        modelContext.insert(newJournalEntry)
        journals.append(newJournalEntry)
        isEditing = false
    }
    
    
    func updateJournals(_ journal: Journal, modelContext: ModelContext) {
       
        do {
            let fetchDescriptor = FetchDescriptor<Journal>()
            let results = try modelContext.fetch(fetchDescriptor)
            
            if results.contains(journal) {
                for journalFetched in results {
                    if journalFetched.id == journal.id {
                        journalFetched.title = journal.title
                        journalFetched.text = journal.text
                        journalFetched.dailyMood = journal.dailyMood
                        journalFetched.imageData = journal.imageData
                        journalFetched.date = journal.date
                        
                    }
                }
            } else {
                modelContext.insert(journal)
            }
            try modelContext.save()
        } catch  {
            self.error = error
            self.showError.toggle()
        }
    }
    func deleteJournal(_ journal: Journal, modelContext: ModelContext) {
        modelContext.delete(journal)
    }
    
    
    static var preview: JournalManager {
        let preview = JournalManager()
        preview.journals = [.preview1, .preview2, .preview3, .preview4, .preview5, .preview6]
        return preview
    }
    
    func deleteItems(_ journalToDelete: Journal, modelContext: ModelContext) {
        modelContext.delete(journalToDelete)
    }
}
