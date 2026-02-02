//
//  Camenbert.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import SwiftUI
import Charts

struct HumeurFréquenciesView: View {
    var graphManager: MoodStatisticsManager = MoodStatisticsManager()
    var journals: [Journal]
    @State private var selectedWeek: WeekEnum = .week
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Fréquence de l'humeur")
                    .foregroundStyle(.secondary)
                Spacer()
//                Picker("Cette semaine", selection: $selectedWeek) {
//                    ForEach(WeekEnum.allCases, id: \.self) { week in
//                        Text(week.rawValue)
//                    }
//                }
//                .pickerStyle(.menu)
            }
            Chart {
                ForEach(MoodType.allCases, id: \.self) { mood in
                    BarMark(x: .value("Humeur", Mood(type: mood).icon), y: .value("Semaine dernière", graphManager.getMoodFrequencies(journals: journals)[mood] ?? 0))
                        .foregroundStyle(Mood(type: mood).color)
                }
            }
            .chartYScale(domain: 0...journals.count)
            .chartXAxisLabel("Humeurs")
            .chartYAxisLabel("Récurrences")
            .chartYAxis(content: {
                AxisMarks(position: .leading)
            })
        }
        .padding()
    }
}

#Preview {
    HumeurFréquenciesView(graphManager: MoodStatisticsManager(), journals: [.preview1, .preview2, .preview3, .preview4, .preview5,.preview1,.preview1,.preview1,.preview1])
}
