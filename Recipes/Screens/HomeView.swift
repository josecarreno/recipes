//
//  HomeView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

struct HomeView: View {
    @Environment(RecipesModel.self) var model
    @State private var isAddRecipeViewPresented = false

    var body: some View {
        NavigationView {
            VStack {
                switch model.recipes {
                case .loading:
                    ProgressView()
                case .error(let message):
                    Label(message, systemImage: "exclamationmark.triangle.fill")
                case .loaded:
                    @Bindable var bindingModel = model

                    List(model.filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack {
                                Image(recipe.smallImage, bundle: .main)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .background(.gray)
                                    .cornerRadius(8)
                                Text(recipe.name)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    model.removeRecipe(id: recipe.id)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        }
                    }
                    .searchable(text: $bindingModel.searchText)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add recipe", systemImage: "plus") {
                        isAddRecipeViewPresented = true
                    }
                }
            }
        }
        .sheet(isPresented: $isAddRecipeViewPresented) {
            AddRecipeView()
        }
        .task {
            await model.fetchRecipes()
        }
    }
}

#Preview {
    HomeView()
        .environment(RecipesModel(recipesService: RecipesLocalService()))
        .environment(MapModel())
}
