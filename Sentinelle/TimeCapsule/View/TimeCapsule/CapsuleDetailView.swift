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

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                // Capsule Information
                Group {
                    if Date() >= capsule.openDate {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Capsule créée le \(capsule.creationDate, style: .date)")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            Divider()
                            Text(capsule.message)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.bottom, 10)
                                .lineSpacing(5)
                        }
                        .onAppear() {
                            capsule.isOpened = true
                        }
                        // Action Button
                        Button(action: {
                            withAnimation {
                                capsule.isOpened = false
                            }
                        }) {
                            Text("Marquer comme non lue")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        .padding(.top, 10)
                        .accessibilityLabel("Bouton pour marquer la capsule comme ouverte")
                    } else {
                        Text("Cette capsule sera disponible le \(capsule.openDate, style: .date).")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                            .multilineTextAlignment(.center)
                            .accessibilityLabel("Date d'ouverture prévue : \(capsule.openDate, style: .date)")
                    }
                }
                .padding()
                Spacer()
            }
            
            .font(.system(size: 17, weight: .regular, design: .serif))
            .navigationTitle("Détails de la Capsule")
            .padding(.top)
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    NavigationStack {
        CapsuleDetailView(capsule: TimeCapsule(message: """
                                               Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression.
                                               """, openDate: .now))
    }
}
