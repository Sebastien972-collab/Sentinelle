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
    @State private var buttonScale: CGFloat = 1.0 // Animation
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var capsuleTimeManager = TimeCapsuleManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                SunsetGradientView()
                ScrollView {
                    VStack {
                        // Titre et explication de la fonctionnalité
                        Text("Capsule Temporelle")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                            .padding()
                        Text("Écrivez un message pour votre futur vous. Choisissez une date et laissez la capsule vous surprendre lorsque vous l’ouvrirez.")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                            .padding([.leading, .trailing])
                        
                        // Champ de texte pour le message
                        TextEditor(text: $message)
                            .frame(height: 200)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.indigo, lineWidth: 2))
                            .padding(.horizontal)
                            .focused($isFocused)
                        
                        // Sélecteur de date
                        DatePicker("Choisir une date d’ouverture", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding(.top)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        // Bouton pour sauvegarder le message
                        Button(action: {
                            // Démarrer l'animation
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                                buttonScale = 0.8 // Le bouton rétrécit
                                isMessageSaved = true
                            }
                            // Sauvegarder la capsule
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                capsuleTimeManager.addCapsule(message: message, openDate: selectedDate, modelContext: modelContext)
                                dismiss()
                            }
                            
                            
                        }) {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath.fill")
                                    .font(.title)
                                Text("Envoyer dans la Capsule")
                                    .fontWeight(.bold)
                                    .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(12)
                            .shadow(radius: 10)
                            .scaleEffect(buttonScale) // Appliqu
                        }
                        .padding(.bottom)
                        
                        // Message de confirmation une fois la capsule sauvegardée
                        if isMessageSaved {
                            Text("Votre message a été envoyé dans la capsule !")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                                .padding()
                        }
                    }
                    .padding()
                    .toolbar {
                        //                        ToolbarItem(placement: .topBarLeading) {
                        //                            Button("Annuler") {
                        //                                dismiss()
                        //                            }
                        //                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                guard isFocused else { return dismiss() }
                                isFocused.toggle()
                            } label: {
                                Text("OK")
                                    .bold()
                            }

                            
                        }
                        
                    }
                }
            }
        }
        }
    
    // Fonction pour sauvegarder la capsule (implémentation fictive)
    func saveCapsule() {
        // Code pour sauvegarder la capsule dans la base de données ou un stockage local
        print("Message enregistré : \(message) pour la date : \(selectedDate)")
    }
}

#Preview {
    CapsulTimeView()
}
