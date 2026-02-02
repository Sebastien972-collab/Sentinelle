//
//  ImageView.swift
//  Sentinelle
//
//  Created by Sebby on 21/11/2024.
//

import SwiftUI

struct ImageView: View {
    let image: Image
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                image
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Fermer") {
                    self.dismiss()
                }
            }
        }
    }
}

#Preview {
    ImageView(image: Image("Noir"))
}
