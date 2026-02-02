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
                        SectorMark(angle: .value(frequency.mood.rawValue, Double(frequency.frequency)), innerRadius: .ratio(0.8), outerRadius: .ratio(1))
                            .foregroundStyle(frequency.mood.getMood().color)
                    }
                })
                .frame(height: 250)
                VStack {
                    ForEach(moodsFrequencies) { frequency in
                        HStack {
                            frequency.mood.getMood().color
                                .clipShape(Circle())
                                .frame(width: 10, height: 10)
                            Text(frequency.mood.rawValue)
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
    CamembertView(graphManager: MoodStatisticsManager(), moodsFrequencies: [MoodFrequency(mood: MoodType.happy, frequency: 7), MoodFrequency(mood: .sad, frequency: 10), MoodFrequency(mood: .neutral, frequency: 5)])
}
