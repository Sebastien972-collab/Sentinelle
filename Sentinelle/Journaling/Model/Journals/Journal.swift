//
//  Journal.swift
//  Sentinelle
//
//  Created by Sebby on 02/11/2024.
//

import Foundation
import SwiftData
#if canImport(JournalingSuggestions)
import JournalingSuggestions
#endif
import UIKit

@Model
class Journal: Identifiable {
    var id: String = UUID().uuidString
    var date: Date
    var title: String
    var text: String
    var dailyMood: String
    var imageData: [Data]
    
    init(date: Date, title: String, text: String, dailyMood: MoodType) {
        self.date = date
        self.title = title
        self.text = text
        self.dailyMood = dailyMood.rawValue
        self.imageData = []
    }
    
    init(date: Date, title: String, text: String, dailyMood: MoodType, imageData: [Data]) {
        self.date = date
        self.title = title
        self.text = text
        self.dailyMood = dailyMood.rawValue
        self.imageData = imageData
    }
    
    func wordCount () -> Int {
        let words = text.split(separator: " ")
        return words.count
    }
    func dateFormated() -> String {
        date.formatted(.relative(presentation: .named))
    }
#if canImport(JournalingSuggestions)
    static func convertSuggestionToJournal(_ suggestion: JournalingSuggestion) async -> Journal {
        let journal = Journal(date: suggestion.date?.start ?? Date(), title: suggestion.title, text: "", dailyMood: .neutral)
        let suggestionContent = await suggestion.content (forType: UIImage.self).map {  $0 }
        if #available(iOS 18.0, *) {
            if let reflection = await suggestion.content(forType: JournalingSuggestion.Reflection.self).first {
                journal.text = reflection.prompt
            }
            if let stateOfMind = await suggestion.content(forType: JournalingSuggestion.StateOfMind.self).first {
                if stateOfMind.state.valence >= 0.5 {
                    journal.dailyMood = MoodType.happy.rawValue
                } else if stateOfMind.state.valence < -0.5 {
                    journal.dailyMood = MoodType.neutral.rawValue
                } else {
                    journal.dailyMood = MoodType.sad.rawValue
                }
            }
             
            
        } else {
            // Fallback on earlier versions
        }
        
        for suggestion in suggestionContent {
            if let imageData = suggestion.jpegData(compressionQuality: 0.8) {
                    // imageData est maintenant un objet Data
                journal.imageData.append(imageData)
                }
        }
        return journal
    }
#endif
    
   
    
    
    
    
    
    
    
    
    
    static var preview1: Journal = Journal(date: randomDate(),title: "Mon titre du journal", text: "Aujourd'hui, je suis reconnaissant pour : 1. Le café que j'ai partagé avec mon ami ce matin.\n 2. Le soleil qui brillait pendant ma promenade.\n 3. La gentillesse de ma collègue qui m'a aidé avec un projet difficile.", dailyMood: .motivated)
    static var preview2: Journal = Journal(date: randomDate(), title: "", text: "Pratiques de bien:- J'ai médité pendant 10 minutes ce matin.\n - J'ai pris le temps de lire un livre en soirée.\n- J'ai essayé une nouvelle recette saine pour le dîner.", dailyMood: .angry)
    static var preview3: Journal = Journal(date: randomDate(),title: "Mon titre du journal", text: "Aujourd'hui, je suis reconnaissant pour : 1. Le café que j'ai partagé avec mon ami ce matin.\n 2. Le soleil qui brillait pendant ma promenade.\n 3. La gentillesse de ma collègue qui m'a aidé avec un projet difficile.", dailyMood: .calm)
    static var preview4: Journal = Journal(date: randomDate(), title: "", text: "Pratiques de bien:- J'ai médité pendant 10 minutes ce matin.\n - J'ai pris le temps de lire un livre en soirée.\n- J'ai essayé une nouvelle recette saine pour le dîner.", dailyMood: .jubilant)
    static var preview5: Journal = Journal(date: randomDate(),title: "Today's journal", text: "Aujourd'hui, je suis reconnaissant pour : 1. Le café que j'ai partagé avec mon ami ce matin.\n 2. Le soleil qui brillait pendant ma promenade.\n 3. La gentillesse de ma collègue qui m'a aidé avec un projet difficile.", dailyMood: .depressed)
    static var preview6: Journal = Journal(date: randomDate(), title: "Mon titre du journal", text: "Pratiques de bien:- J'ai médité pendant 10 minutes ce matin.\n - J'ai pris le temps de lire un livre en soirée.\n- J'ai essayé une nouvelle recette saine pour le dîner.", dailyMood: .neutral)
    static var preview7: Journal = Journal(date: randomDate(), title: "Mon titre du journal", text: "Pratiques de bien:- J'ai médité pendant 10 minutes ce matin.\n - J'ai pris le temps de lire un livre en soirée.\n- J'ai essayé une nouvelle recette saine pour le dîner.", dailyMood: .neutral)
    
    static private func randomDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy" //
        let startDate = formatter.date(from: "01-01-2020")!
        let endDate = formatter.date(from: "12-31-2024")!
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval(arc4random_uniform(UInt32(timeInterval)))
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    
    
    
}
extension Array where Element == Journal {
    func moodFrequency() -> [(String, Int)] {
        var frequency: [String: Int] = [:]
        for journal in self {
            frequency[journal.dailyMood, default: 0] += 1
        }
        return frequency.sorted(by: { $0.value > $1.value })
    }
    
    func entriesPerMonth() -> [(String, Int)] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        var monthlyEntries: [String: Int] = [:]
        for journal in self {
            let month = dateFormatter.string(from: journal.date)
            monthlyEntries[month, default: 0] += 1
        }
        return monthlyEntries.sorted(by: { $0.key < $1.key })
    }
    
    func wordsPerDay() -> [(Date, Int)] {
        var wordCounts: [Date: Int] = [:]
        for journal in self {
            let day = Calendar.current.startOfDay(for: journal.date)
            wordCounts[day, default: 0] += journal.wordCount()
        }
        return wordCounts.sorted(by: { $0.key < $1.key })
    }
}
