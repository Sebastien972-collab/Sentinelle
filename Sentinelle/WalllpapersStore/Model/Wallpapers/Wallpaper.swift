//
//  Wallpaper.swift
//  Sentinelle
//
//  Created by Sebby on 18/11/2024.
//

import Foundation

enum WallpaperCategory: String, CaseIterable {
    case all = "Tous les fond d'écrands"
    case colorful = "Fond d'écran de couleur"
    case images = "Images"
    
}

struct Wallpaper: Identifiable {
    let id: UUID = UUID()
    let name: String
    let imageName: String
    let category: WallpaperCategory
    let price: Double?
    
    static let preview: Wallpaper =  Wallpaper(name: "Drake - Honestly Nevermind", imageName: "Noir", category: .images, price: 1.99)
    static var previews: [Wallpaper] {
        [.preview, Wallpaper(name: "Biggie", imageName: "wallpaper1", category: .images, price: nil)
         , Wallpaper(name: "Chat", imageName: "wallpaper2", category: .images, price: nil)
         , Wallpaper(name: "Drake", imageName: "wallpaper3", category: .images, price: 1.99)
         , Wallpaper(name: "For all the dogds scary hour", imageName: "wallpaper4", category: .images, price: 4.99)
         , Wallpaper(name: "Drake&Jcole", imageName: "wallpaper5", category: .images, price: 5.99)
         , Wallpaper(name: "2Pac", imageName: "wallpaper7", category: .images, price: nil)
        ]
    }
    
    
}
