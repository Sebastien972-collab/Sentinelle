//
//  JournalImagesView.swift
//  Sentinelle
//
//  Created by Sebby on 02/12/2024.
//

import SwiftUI

struct JournalImagesView: View {
    @State var journal: Journal
    var body: some View {
        HStack {
            // Affiche les images
            if journal.imageData.count == 1,
               let imageData = journal.imageData.first,
               let uiImage = UIImage(data: imageData) {
                // Une seule image : pleine largeur
                NavigationLink {
                    ImageDetailView(journal: journal)
                        .padding()
                } label: {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius:10.5))
                        .padding(3)
                }

                
                
            } else if journal.imageData.count > 1 {
                // Plusieurs images : grille horizontale
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.flexible(minimum: 100))], spacing: 10) {
                        ForEach(0..<journal.imageData.count, id: \.self) { index in
                            if let uiImage = UIImage(data: journal.imageData[index]) {
                                NavigationLink {
                                    ImageDetailView(journal: journal, currentIndex: index)
                                        .padding()
                                } label: {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 300)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.gray.opacity(0.1))
                .padding()
            }
        }
    }
}

#Preview {
    JournalImagesView(journal: .preview1)
}
