//
//  WallpaperRow.swift
//  Sentinelle
//
//  Created by Sebby on 18/11/2024.
//

import SwiftUI

struct WallpaperRow: View {
    var wallpaper: Wallpaper
    @State private var showPopover: Bool = false
    var body: some View {
        VStack(alignment: .center) {
            Image(wallpaper.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack(spacing: 3) {
                AddJournalButtonView(title: wallpaper.price != nil ? "\(wallpaper.price!) €" : "Obtenir", systemImageName: nil, action: {})
                    .frame(width: 150)
                Button {
                    showPopover.toggle()
                } label: {
                    Image(systemName: "i.circle")
                        .foregroundStyle(.secondary)
                }

            }
        }
        .popover(isPresented: $showPopover) {
            VStack {
                Text("Détails")
                Text("Nom: \(wallpaper.name)")
                Text("Catégorie: \(wallpaper.category.rawValue)")
            }
        }
        .presentationCompactAdaptation(.popover)
        .frame(width: 200)
        .padding()
        
    }
}

#Preview {
    WallpaperRow(wallpaper: .preview)
}
