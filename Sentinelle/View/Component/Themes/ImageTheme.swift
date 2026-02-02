//
//  ImageTheme.swift
//  Sentinelle
//
//  Created by Sebby on 18/11/2024.
//

import SwiftUI

struct ImageTheme: View {
    let imageName: String
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Text("Hello")
        }
    }
}

#Preview {
    ImageTheme(imageName: "Noir")
}
