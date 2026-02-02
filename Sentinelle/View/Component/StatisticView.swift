//
//  StatisticView.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import SwiftUI
import Charts // SwitchArt Charts importé


struct StatisticsView: View {
    var journals: [Journal]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Analysez vos habitudes et votre progression.")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                StatisticsCardView(title: "Mes entrées", color: .customBlue) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Continuer à tenir votre journal pour voir les changements")
                            .font(.headline)
                            .foregroundColor(.white)
                        Divider()
                        Text("\(journals.count) entrée\(journals.count > 1 ? "s" : "")")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                }
                // Section : Répartition des humeurs
                VStack {
                    StatisticsCardView(title: "Répartition des humeurs", color: .customBlue) {
                        Chart(journals.moodFrequency(), id: \.0) { mood, count in
                            SectorMark(
                                angle: .value("Fréquence", count),
                                innerRadius: .ratio(0.5),
                                outerRadius: .ratio(1.0)
                            )
                            .foregroundStyle(by: .value("Humeur", mood))
                        }
                        .chartLegend(.visible)
                        
                    }
                    .frame(height: 250)
                    StatisticsCardView(title: "Répartition des humeurs", color: .customBlue) {
                        HumeurFréquenciesView(journals: journals)
                            .frame(height: 200)
                    }
                }
                

                // Section : Entrées par mois
                HStack(content: {
                    StatisticsCardView(title: "Entrées par mois", color: .customBlue) {
                        Chart(journals.entriesPerMonth(), id: \.0) { month, count in
                            BarMark(
                                x: .value("Mois", month),
                                y: .value("Entrées", count)
                            )
                            .foregroundStyle(.blue.gradient)
                        }
                        .chartXAxis {
                            AxisMarks { value in
                                AxisValueLabel()
                            }
                        }
                    }
                    .frame(height: 200)
                    // Section : Mots écrits quotidiennement
                    StatisticsCardView(title: "Mots écrits quotidiennement", color: .customBlue) {
                        Chart(journals.wordsPerDay(), id: \.0) { date, words in
                            LineMark(
                                x: .value("Date", date),
                                y: .value("Mots", words)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(.white.gradient)
                        }
                        
                    }
                    .frame(height: 200)
                })
                
                .navigationTitle(Text("Statistiques"))
            }
            .padding()
        }
    }
}

// Composant pour les cartes statistiques
struct StatisticsCardView<Content: View>: View {
    let title: String
    let color: Color
    let content: Content

    init(title: String, color: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.color = color
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top)
            content
                .padding(.horizontal)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(color.gradient)
        .cornerRadius(15)
        .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}
#Preview {
    NavigationStack {
        StatisticsView(journals: [.preview1, .preview2, .preview3, .preview4, .preview5, .preview6, .preview7])
    }
}
