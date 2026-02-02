//
//  GridItemView.swift
//  Sentinelle
//
//  Created by Sebby on 27/11/2024.
//

import SwiftUI

struct GridItemView: View {
    let journalImageData: Data

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image = UIImage(data: journalImageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()

            }
            
        }
        //.frame(width: size, height: size)
    }
}
#Preview {
    GeometryReader { geometry in
        GridItemView(journalImageData: getDatas(imageName: ["wallpaper1"])[0])
    }
    .frame(width: 300, height: 300)
}
