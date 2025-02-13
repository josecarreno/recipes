//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @State var isShowingMapView = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ImageDisplay(details: recipe.largeImage)
                    .frame(maxWidth: .infinity)

                Button {
                    isShowingMapView.toggle()
                } label: {
                    Label(recipe.origin, systemImage: "location.circle")
                }

                Text("Ingredients: \(recipe.ingredients.joined(separator: ", "))")
                    .font(.headline)

                Text(recipe.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .sheet(isPresented: $isShowingMapView) {
            OriginMapView(
                title: "\(recipe.name) origin location",
                origin: recipe.origin
            )
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(
        id: "1",
        name: "Paella",
        description: "Delicious Spanish rice dish",
        smallImage: ImageDetails(source: "paella_small", type: .asset),
        largeImage: ImageDetails(source: "paella_large", type: .asset),
        ingredients: ["Rice", "Seafood", "Chicken"],
        origin: "Valencia, Spain")
    )
}
