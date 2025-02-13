//
//  RecipesStorage.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import Observation

@MainActor
@Observable
class RecipesModel {
    var searchText = ""
    var recipes: DataState<[Recipe]> = .loading

    var filteredRecipes: [Recipe] {
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

    let recipesService: RecipesService

    init(recipesService: RecipesService) {
        self.recipesService = recipesService
    }

    func fetchRecipes() async {
        recipes = .loading
        do {
            let result = try await recipesService.fetch()
            recipes = .loaded(data: result)
        } catch {
            recipes = .error(message: "Error fetching recipes")
        }
    }

    func removeRecipe(id: String) {
        guard var data = recipes.value else { return }

        data.removeAll(where: { $0.id == id})

        recipes = .loaded(data: data)
    }

    func addRecipe(recipe: Recipe) {
        guard var data = recipes.value else { return }

        data.append(recipe)

        recipes = .loaded(data: data)
    }
}


