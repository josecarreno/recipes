//
//  DetailView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

struct DetailView: View {
    let recipe: Recipe

    @State var isShowingMapView = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(recipe.largeImage)
                    .resizable()
                    .scaledToFit()
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
            MapView(
                title: "\(recipe.name) origin location",
                origin: recipe.origin
            )
        }
    }
}

#Preview {
    DetailView(recipe: Recipe(
        id: "1",
        name: "Paella",
        description: "Delicious Spanish rice dish",
        smallImage: "paella_small",
        largeImage: "paella_large",
        ingredients: ["Rice", "Seafood", "Chicken"],
        origin: "Valencia, Spain")
    )
}
