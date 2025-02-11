//
//  HomeView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

struct HomeView: View {
    @Environment(RecipesModel.self) var model

    var body: some View {
        NavigationView {
            VStack {
                switch model.recipes {
                case .loading:
                    ProgressView()
                case .error(let message):
                    Label(message, systemImage: "exclamationmark.triangle.fill")
                case .loaded:
                    @Bindable var model = model

                    List(model.filteredRecipes) { recipe in
                        NavigationLink(destination: DetailView(recipe: recipe)) {
                            HStack {
                                Image(recipe.smallImage, bundle: .main)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .background(.gray)
                                    .cornerRadius(8)
                                Text(recipe.name)
                            }
                        }
                    }
                    .searchable(text: $model.searchText)
                }
            }
            .navigationTitle("Recipes")
            .task {
                await model.fetchRecipes()
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(RecipesModel(recipesService: RecipesLocalService()))
}
