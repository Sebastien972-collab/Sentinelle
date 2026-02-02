//
//  CapsulTimeView.swift
//  Sentinelle
//
//  Created by Sebby on 20/11/2024.
//

import SwiftUI

struct CapsulTimeView: View {
    @State private var message: String = ""
    @State private var selectedDate = Date()
    @State private var isMessageSaved = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var capsuleTimeManager = TimeCapsuleManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fond immersif
                SunsetGradientView()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        headerSection
                        writingArea
                        datePickerSection
                        Spacer(minLength: 30)
                        sendButton
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Annuler") { dismiss() }
                        .foregroundStyle(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    if isFocused {
                        Button("OK") { isFocused = false }
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    
    // MARK: - Sous-Vues (UX Components)
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "clock.arrow.2.circlepath")
                .font(.system(size: 40))
                .foregroundStyle(.white)
                .symbolEffect(.pulse)
            
            Text("Capsule Temporelle")
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .foregroundStyle(.white)
            
            Text("Écrivez à votre futur vous.\nCe message restera scellé jusqu'à la date choisie.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal)
        }
        .padding(.top, 10)
    }
    
    private var writingArea: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "square.and.pencil")
                Text("Votre message")
            }
            .font(.caption)
            .fontWeight(.bold)
            .foregroundStyle(.white.opacity(0.7))
            .padding(.leading, 10)
            
            TextEditor(text: $message)
                .scrollContentBackground(.hidden) // Cache le fond blanc par défaut
                .frame(height: 180)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                )
                .focused($isFocused)
                .foregroundStyle(.white)
        }
    }
    
    private var datePickerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "calendar.badge.clock")
                Text("Date de réouverture")
            }
            .font(.caption)
            .fontWeight(.bold)
            .foregroundStyle(.white.opacity(0.7))
            .padding(.leading, 10)
            
            DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(.indigo)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        }
    }
    
    private var sendButton: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                isMessageSaved = true
                capsuleTimeManager.addCapsule(message: message, openDate: selectedDate, modelContext: modelContext)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                dismiss()
            }
        } label: {
            HStack(spacing: 15) {
                if isMessageSaved {
                    ProgressView()
                        .tint(.white)
                    Text("Scellage en cours...")
                } else {
                    Image(systemName: "lock.fill")
                    Text("Sceller la Capsule")
                }
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                LinearGradient(colors: [Color.indigo, Color.purple.opacity(0.8)],
                               startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 40)
        }
        .disabled(message.isEmpty || isMessageSaved)
        .opacity(message.isEmpty ? 0.6 : 1.0)
    }
}

#Preview {
    CapsulTimeView()
}
