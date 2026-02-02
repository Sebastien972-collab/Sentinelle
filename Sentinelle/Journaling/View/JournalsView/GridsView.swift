//
//  GridsView.swift
//  Sentinelle
//
//  Created by Sebby on 26/11/2024.
//

import SwiftUI
import UIKit
struct GridsView: View {
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 3)
    var imagesData: [Data]
    private var columns: [GridItem] {
            return [GridItem(.flexible(minimum: 100, maximum: 150), spacing: 2), GridItem(.flexible(minimum: 100, maximum: 150), spacing: 2)]
    }
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(imagesData, id: \.self) { imageData in
                GridItemView(journalImageData: imageData)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 350)
        .padding(2)
        
    }
}
func getDatas(imageName: [String]) -> [Data] {
    // Assurez-vous que vous avez une UIImage
    var datas: [Data] = []
    for name in imageName {
        if let name = UIImage(named: name) {
            
            // Convertir en JPEG (avec une qualité de 0.8, 1.0 étant la meilleure qualité)
            if let imageData = name.jpegData(compressionQuality: 0.8) {
                // imageData est maintenant de type Data
                print("Image convertie en JPEG : \(imageData.count) octets")
                datas.append(imageData)
            }
        }
        
    }
    return datas
    
}

#Preview {
    GridsView(imagesData: getDatas(imageName: ["wallpaper1","wallpaper2","wallpaper3","wallpaper4","wallpaper5","wallpaper7"] ))
}
