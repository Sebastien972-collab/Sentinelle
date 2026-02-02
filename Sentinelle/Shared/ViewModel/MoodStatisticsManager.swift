//
//  MoodStatisticsManager.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import Foundation

class MoodStatisticsManager {
    
    func getMoodFrequencies(journals: [Journal]) -> [MoodType: Int] {
        
        var frequencies: [MoodType: Int] = [:]
        
        for journal in journals {
            let mood = Mood.getMood(journal.dailyMood)
            let value = frequencies[mood.type] ?? 0
            frequencies.updateValue(value + 1, forKey: mood.type)
        }
        return frequencies
    }
    
    func getMoodPercentages(journals: [Journal]) -> [MoodType: Int] {
        var frequencies: [MoodType: Int] = getMoodFrequencies(journals: journals)
        var totalMoods: Int {
            var total: Int = 0
            for frequency in frequencies {
                total += frequency.value
            }
            return total
        }
        
        for frequency  in frequencies {
            let percentage = Double(frequency.value) / Double(totalMoods)
            frequencies.updateValue(Int(round(percentage * 100)), forKey: frequency.key)
        }
        return frequencies
    }
    func camembertFilter(journals: [Journal]) -> [MoodFrequency] {
        let frequecies = getMoodPercentages(journals: journals)
        var moodsFrequecies: [MoodFrequency] = []
        for frequecy in frequecies {
            if frequecy.value > 0 {
                moodsFrequecies.append(MoodFrequency(moodType: frequecy.key, frequency: Int(Double(frequecy.value))))
                
            }
        }
        return moodsFrequecies.sorted { $0.frequency > $1.frequency }
    }
}
