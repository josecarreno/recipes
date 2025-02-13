//
//  ImageDisplay.swift
//  RecipesApp
//
//  Created by Jose Bernardo Carreno Castillo on 13/02/25.
//

import SwiftUI

struct ImageDisplay: View {
    let details: ImageDetails

    var body: some View {
        VStack {
            if details.type == .asset {
                Image(details.source)
                    .resizable()
                    .scaledToFill()
                    .background(.gray)
            } else if details.type == .remote {
                AsyncImage(url: URL(string: details.source)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable let asset = ImageDetails(source: "paella_small", type: .asset)
    @Previewable let remote = ImageDetails(
        source: "https://img.freepik.com/fotos-premium/paella-marisco-tradicional-espanola-sarten-sobre-fondo-blanco_222237-372.jpg?semt=ais_hybrid",
        type: .remote)

    ImageDisplay(details: asset)

    ImageDisplay(details: remote)
}
