//
//  CapsuleTimeButton.swift
//  Sentinelle
//
//  Created by Sebby on 20/11/2024.
//

import SwiftUI

struct CapsuleTimeButton: View {
    @State private var isPresented: Bool = false
    @State private var goToTheFutur: Bool = false
    @State private var capsulesIsPresented: Bool = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                Button(action:{
                    goToTheFutur.toggle()
                }) {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath") // Icône symbolique
                            .font(.title2)
                            .padding(.trailing, 8)
                        Text("Ouvrir la Capsule Temporelle")
                            .fontWeight(.bold)
                            .font(.headline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            colors: [Color.blue, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
                    .shadow(color: Color.purple.opacity(0.6), radius: 10, x: 0, y: 5)
                }
                HStack(alignment: .center, spacing: 10) {
                    Button("Qu'est ce que c'est ?") {
                        isPresented.toggle()
                    }
                }
                .padding(.horizontal)
            }
            .padding()
            .sheet(isPresented: $isPresented) {
                Text("La capsule temporelle est un espace unique où vous pouvez écrire un message pour votre futur vous. Partagez vos pensées, vos rêves ou même vos défis du moment, et fixez une date pour rouvrir cette capsule. À la date choisie, vous recevrez votre message, comme une lettre venue du passé. ")
                    .padding()
                    .font(.system(size: 24, weight: .regular, design: .serif))
            }
            .sheet(isPresented: $goToTheFutur, content: { CapsulTimeView() })
        }
    }
}

#Preview {
    CapsuleTimeButton()
}
