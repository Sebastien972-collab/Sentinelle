//
//  CamembertView.swift
//  Sentinelle
//
//  Created by Sebby on 15/11/2024.
//

import SwiftUI
import Charts

struct CamembertView: View {
    let graphManager: MoodStatisticsManager
    var moodsFrequencies: [MoodFrequency]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mon humeur du moment: ")
                .foregroundStyle(.secondary)
            HStack {
                Chart(content: {
                    ForEach(moodsFrequencies) { frequency in
                        SectorMark(angle: .value(frequency.moodType.rawValue, Double(frequency.frequency)), innerRadius: .ratio(0.8), outerRadius: .ratio(1))
                            .foregroundStyle(Mood(type: frequency.moodType).color)
                    }
                })
                .frame(height: 250)
                VStack {
                    ForEach(moodsFrequencies) { frequency in
                        HStack {
                            Mood(type: frequency.moodType).color
                                .clipShape(Circle())
                                .frame(width: 10, height: 10)
                            Text(frequency.moodType.rawValue)
                                .font(.subheadline)
                            Text("\(Int(frequency.frequency))%")
                        }
                    }
                }
            }
        }
        .padding()
    }
}
#Preview {
    CamembertView(graphManager: MoodStatisticsManager(), moodsFrequencies: [MoodFrequency(moodType: MoodType.happy, frequency: 7), MoodFrequency(moodType: .sad, frequency: 10), MoodFrequency(moodType: .neutral, frequency: 5)])
}
