//
//  ImageRoundedRecatangleView.swift
//  Sentinelle
//
//  Created by Sebby on 13/11/2024.
//

import SwiftUI

struct ImageRoundedRecatangleView: View {
    @State private var photIsExpanded: Bool = false
    var image: Image
    var size: Double
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
            .padding(5)
//            .onTapGesture {
//                withAnimation(.easeInOut(duration: 0.6)) {
//                    DispatchQueue.main.async {
//                        photIsExpanded.toggle()
//                    }
//                }
//            }
            .sheet(isPresented: $photIsExpanded) {
                ImageView(image: image)
            }
        
        
    }
}

#Preview {
    ImageRoundedRecatangleView(image: Image("wallpaper1"), size: 200)
        .padding()
}
