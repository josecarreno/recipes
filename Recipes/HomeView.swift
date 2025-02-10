//
//  HomeView.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var recipes: DataState<[Recipe]> = .loading

    private var filteredRecipes: [Recipe] {
        switch recipes {
        case .loading, .error:
            return []
        case .loaded(let recipes):
            let filter = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

            guard !filter.isEmpty else { return recipes }

            return recipes.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.contains { $0.localizedStandardContains(searchText)}
            }
        }
    }

    private let recipesService = RecipesService()

    var body: some View {
        NavigationView {
            VStack {
                switch recipes {
                case .loading:
                    ProgressView()
                case .error(let message):
                    Label(message, systemImage: "exclamationmark.triangle.fill")
                case .loaded:
                    List {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink(destination: DetailView(recipe: recipe)) {
                                HStack {
                                    Image(recipe.smallImage, bundle: .main)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .background(.gray)
                                    Text(recipe.name)
                                }
                            }
                        }

                    }
                    .searchable(text: $searchText)
                }
            }
            .navigationTitle("Recipes")
            .task { @MainActor in
                do {
                    let result = try await recipesService.fetch()
                    recipes = .loaded(data: result)
                } catch {
                    recipes = .error(message: "Error fetching recipes")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
