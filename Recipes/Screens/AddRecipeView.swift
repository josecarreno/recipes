//
//  AddRecipeView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(RecipesModel.self) var model
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var origin: String = ""
    @State private var ingredients: [String] = []
    @State private var smallImage: String = ""
    @State private var largeImage: String = ""


    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Form {
                Section("Basic information") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Origin", text: $origin)
                }
            }

            Button("Add recipe") {
                let recipeToAdd = Recipe(
                    id: UUID().uuidString,
                    name: name,
                    description: description,
                    smallImage: "",
                    largeImage: "",
                    ingredients: [],
                    origin: origin
                )

                model.addRecipe(recipe: recipeToAdd)

                dismiss()
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    let recipesModel = RecipesModel(recipesService: RecipesLocalService())

    AddRecipeView()
        .environment(recipesModel)
}
