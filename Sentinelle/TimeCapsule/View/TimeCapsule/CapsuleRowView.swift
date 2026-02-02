//
//  CapsuleRowView.swift
//  Sentinelle
//
//  Created by Sebby on 09/01/2025.
//

import SwiftUI

struct CapsuleRowView: View {
    let capsule: TimeCapsule

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                if Date.now < capsule.openDate {
                    HStack {
                        Text("Créer le:")
                        Text(capsule.creationDate, style: .date)
                            .environment(\.locale, Locale(identifier: "fr_FR"))
                            
                    }
                    .fontWeight(.heavy)
                    .foregroundStyle(.secondary)
                    
                } else {
                    Text(capsule.message)
                        .fontWeight(.heavy)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                
                Text("\(capsule.isOpened ? "Ouverte le" : "À ouvrir le") \(capsule.openDate, style: .date)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: capsule.isOpened ? "envelope.open.fill" :"envelope.fill")
                .font(.subheadline)
                .foregroundColor(.green)
                .padding(6)
               // .foregroundStyle(Date() >= capsule.openDate ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                
        }
        .font(.system(size: 17, weight: .regular, design: .serif))
    }
}

#Preview {
    Form {
        CapsuleRowView(capsule: TimeCapsule(message: "Sebby est le meilleur", openDate: .now))
            .environmentObject(TimeCapsuleManager.shared)
    }
}
