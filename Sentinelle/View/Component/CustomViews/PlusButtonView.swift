//
//  PlusButtonView.swift
//  Sentinelle
//
//  Created by Sebby on 03/11/2024.
//

import SwiftUI

struct PlusButtonView: View {
    @StateObject var manager: AppearanceManager = .shared
    var action: () -> Void
    var body: some View {
        Button {
            NotificationManager.triggerImpactFeedback()
            action()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .background {
                    manager.currentPlusButtonColor
                        .frame(width: 60, height: 60)
                        .overlay {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                        }
                        .shadow(radius: 5)
                        .clipShape(Circle())
                }
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    ZStack {
        SunsetGradientView()
        PlusButtonView(action: {
            print("Tapped")
        })
    }
    
}
