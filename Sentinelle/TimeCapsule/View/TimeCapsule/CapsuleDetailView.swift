//
//  CapsuleDetailView.swift
//  Sentinelle
//
//  Created by Sebby on 09/01/2025.
//

import SwiftUI

struct CapsuleDetailView: View {
    @StateObject var capsuleManager: TimeCapsuleManager = .shared
    @Bindable var capsule: TimeCapsule
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // 1. Fond immersif cohérent avec l'application
            SunsetGradientView().ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    // 2. Icône d'état dynamique
                    statusHeader
                        .padding(.top, 40)
                    
                    // 3. Contenu de la capsule
                    if Date() >= capsule.openDate {
                        openedMessageView
                    } else {
                        lockedCountdownView
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(20)
            }
        }
        .navigationTitle("Capsule")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Action de partage ou option
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }

    // MARK: - Subviews

    private var statusHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: Date() >= capsule.openDate ? "envelope.open.fill" : "lock.shield.fill")
                .font(.system(size: 60))
                .foregroundStyle(Date() >= capsule.openDate ? .green : .white)
                .symbolEffect(.bounce, value: capsule.isOpened)
            
            Text(Date() >= capsule.openDate ? "Message du passé" : "Capsule scellée")
                .font(.system(.title2, design: .serif, weight: .bold))
                .foregroundStyle(.white)
        }
    }

    private var openedMessageView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CRÉÉE LE")
                        .font(.caption2).bold().foregroundStyle(.secondary)
                    Text(capsule.creationDate, style: .date)
                        .font(.subheadline).bold()
                }
                Spacer()
                Image(systemName: "quote.opening")
                    .font(.title).foregroundStyle(.blue.opacity(0.3))
            }
            
            Divider()
            
            Text(capsule.message)
                .font(.system(.body, design: .serif))
                .lineSpacing(8)
                .foregroundStyle(.primary)
            
            Divider()
            
            Button {
                withAnimation { capsule.isOpened = false }
                dismiss()
            } label: {
                Text("Refermer pour plus tard")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())
            }
            .padding(.top, 10)
        }
        .padding(25)
        .background(Color(UIColor.systemBackground).opacity(0.85)) // Couleur adaptative liquide
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .onAppear {
            capsule.isOpened = true
        }
    }

    private var lockedCountdownView: some View {
        VStack(spacing: 20) {
            Text("Patience...")
                .font(.headline)
                .foregroundStyle(.white)
            
            Text("Ce message a été écrit pour votre futur vous. Il ne pourra être révélé que le :")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))
            
            Text(capsule.openDate, style: .date)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .padding()
                .background(.white.opacity(0.1))
                .clipShape(Capsule())
                .foregroundStyle(.white)
            
            // Illustration d'attente
            Image(systemName: "hourglass.badge.plus")
                .font(.largeTitle)
                .foregroundStyle(.white.opacity(0.3))
                .symbolEffect(.pulse)
        }
        .padding(30)
        .background(.ultraThinMaterial.opacity(0.2)) // Très léger pour l'effet mystère
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    NavigationStack {
        CapsuleDetailView(capsule: TimeCapsule(message: """
                                               Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.
                                               """, openDate: .now))
    }
}
