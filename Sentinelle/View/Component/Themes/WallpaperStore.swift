//
//  WallpaperStore.swift
//  Sentinelle
//
//  Created by Sebby on 18/11/2024.
//

import SwiftUI

struct WallpaperStore: View {
    let wallpaper: [Wallpaper] = Wallpaper.previews
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(wallpaper) { wallpaper in
                        WallpaperRow(wallpaper: wallpaper)
                    }
                }
            }
            .navigationTitle("Fonds d'écran")
        }
    }
}

#Preview {
    WallpaperStore()
}
