//
//  StatisticView.swift
//  Sentinelle
//
//  Created by Sebby on 09/11/2024.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    var journals: [Journal]
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // Fond immersif
            SunsetGradientView().ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    headerSection
                    
                    // Grille de chiffres clés (High-level insights)
                    keyMetricsGrid
                    
                    // Graphiques détaillés
                    VStack(spacing: 20) {
                        // Section Humeurs
                        StatisticsCardView(title: "Équilibre émotionnel", subtitle: "Répartition de vos humeurs") {
                            Chart(journals.moodFrequency(), id: \.0) { mood, count in
                                SectorMark(
                                    angle: .value("Fréquence", count),
                                    innerRadius: .ratio(0.65),
                                    angularInset: 2
                                )
                                .cornerRadius(5)
                                .foregroundStyle(by: .value("Humeur", mood))
                            }
                            .frame(height: 220)
                            .chartLegend(position: .bottom, spacing: 20)
                        }
                        
                        // Section Activité
                        StatisticsCardView(title: "Rythme d'écriture", subtitle: "Entrées cumulées par mois") {
                            Chart(journals.entriesPerMonth(), id: \.0) { month, count in
                                BarMark(
                                    x: .value("Mois", month),
                                    y: .value("Entrées", count)
                                )
                                .foregroundStyle(.blue.gradient)
                                .cornerRadius(6)
                            }
                            .frame(height: 180)
                            .chartXAxis {
                                AxisMarks(values: .automatic) { _ in
                                    AxisValueLabel().font(.caption2)
                                }
                            }
                        }
                        
                        // Section Intensité
                        StatisticsCardView(title: "Flux de pensée", subtitle: "Mots écrits quotidiennement") {
                            Chart(journals.wordsPerDay(), id: \.0) { date, words in
                                AreaMark(
                                    x: .value("Date", date),
                                    y: .value("Mots", words)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(LinearGradient(colors: [.blue.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom))
                                
                                LineMark(
                                    x: .value("Date", date),
                                    y: .value("Mots", words)
                                )
                                .interpolationMethod(.catmullRom)
                                .lineStyle(StrokeStyle(lineWidth: 3))
                                .foregroundStyle(.blue)
                            }
                            .frame(height: 180)
                        }
                    }
                    .padding(.bottom, 30)
                }
                .padding()
            }
        }
        .navigationTitle("Analyses")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var headerSection: some View {
        VStack(spacing: 5) {
            Text("Votre voyage intérieur")
                .font(.system(.title2, design: .serif, weight: .bold))
            Text("Découvrez les schémas de vos pensées.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding(.top, 10)
    }

    private var keyMetricsGrid: some View {
        HStack(spacing: 15) {
            MetricTile(title: "Total", value: "\(journals.count)", unit: "entrées", icon: "books.vertical.fill")
            MetricTile(title: "Série", value: "12", unit: "jours", icon: "flame.fill")
        }
    }
}

// MARK: - UI Components Optimisés

struct MetricTile: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(title).font(.caption).fontWeight(.bold).foregroundColor(.secondary)
            }
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value).font(.system(.title, design: .rounded)).bold()
                Text(unit).font(.caption2).foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.2), lineWidth: 0.5))
    }
}

struct StatisticsCardView<Content: View>: View {
    let title: String
    let subtitle: String
    let content: Content

    init(title: String, subtitle: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 5)
            
            content
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(.white.opacity(0.15), lineWidth: 0.5))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}
#Preview {
    NavigationStack {
        StatisticsView(journals: [.preview1, .preview2, .preview3, .preview4, .preview5, .preview6, .preview7])
    }
}
