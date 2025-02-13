//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Jose Carreno Castillo.
//

import Testing
import SwiftUI
@testable import Recipes

struct RecipesTests {

    private let recipe1 = Recipe(
        id: "1", name: "Paella", description: "...", smallImage: "paella_small",
        largeImage: "paella_large", ingredients: ["Rice", "Seafood"], origin: "Valencia")
    private let recipe2 = Recipe(
        id: "2", name: "Tacos", description: "...", smallImage: "tacos_small",
        largeImage: "tacos_large", ingredients: ["Tortillas", "Meat"], origin: "Mexico")
    private let recipe3 = Recipe(
        id: "3", name: "Pasta", description: "...", smallImage: "pasta_small",
        largeImage: "pasta_large", ingredients: ["Pasta", "Tomato"], origin: "Italy")

    struct MockRecipesService: RecipesService {
        let recipes: [Recipe]
        let error: Error?

        func fetch() async throws -> [Recipe] {
            if let error {
                throw error
            } else {
                return recipes
            }
        }
    }

    @MainActor
    @Test("Recipe fetching should start with loading state")
    func testRecipeLoadingState() async throws {
        let mockService = MockRecipesService(recipes: [], error: nil)
        let model = RecipesModel(recipesService: mockService)

        @Bindable var bindableModel = model
        let a = $bindableModel.recipes
        

        // Fetch not called.

        switch model.recipes {
        case .loading:
            #expect(true)
        default:
            Issue.record("Recipes should be loading")
        }
    }

    @MainActor
    @Test("Recipe fetching succeeded")
    func testRecipeFetchingSuccess() async throws {
        let recipes = [recipe1, recipe2]
        let mockService = MockRecipesService(recipes: recipes, error: nil)
        let model = RecipesModel(recipesService: mockService)
        await model.fetchRecipes()

        switch model.recipes {
        case .loaded(let fetchedRecipes):
            #expect(fetchedRecipes.count == 2, "Incorrect recipe count")
            #expect(fetchedRecipes[0].name == "Paella", "Incorrect recipe name")
        default:
            Issue.record("Recipes should be loaded")
        }
    }

    @MainActor
    @Test("Recipe fetching error state")
    func testRecipeFetchingError() async throws {
        let mockService = MockRecipesService(recipes: [], error: RecipesServiceError.fileNotFound)
        let model = RecipesModel(recipesService: mockService)
        await model.fetchRecipes()

        switch model.recipes {
        case .error(let errorMessage):
            #expect(errorMessage != nil, "Error message should not be nil")
        default:
            Issue.record("An error should have been reported")
        }
    }

    @MainActor
    @Test("Recipe filtering by name and ingredients")
    func testRecipeFiltering() async throws {
        let recipes = [recipe1, recipe2, recipe3]
        let mockService = MockRecipesService(recipes: recipes, error: nil)

        let model = RecipesModel(recipesService: mockService)
        await model.fetchRecipes()

        #expect(model.filteredRecipes.count == 3, "All recipes should be shown initially")

        model.searchText = "Paella"

        #expect(model.filteredRecipes.count == 1, "Only Paella should be shown")
        #expect(model.filteredRecipes[0].name == "Paella", "Name should be Paella")

        model.searchText = "Rice"
        #expect(model.filteredRecipes.count == 1, "Only Paella should be shown")
        #expect(model.filteredRecipes[0].name == "Paella", "Name should be Paella")

        model.searchText = "Meat"
        #expect(model.filteredRecipes.count == 1, "Only Tacos should be shown")
        #expect(model.filteredRecipes[0].name == "Tacos", "Name should be Tacos")

        model.searchText = "Pizza"
        #expect(model.filteredRecipes.count == 0, "No recipes should be shown")
    }

    @MainActor
    @Test("Recipe adding")
    func testRecipeAdding() async throws {
        let recipes = [recipe1, recipe2]
        let mockService = MockRecipesService(recipes: recipes, error: nil)

        let model = RecipesModel(recipesService: mockService)
        await model.fetchRecipes()

        let originalRecipes = try #require(model.recipes.value)
        #expect(originalRecipes.count == 2, "Incorrect recipes count")

        model.addRecipe(recipe: recipe3)

        let modifiedRecipes = try #require(model.recipes.value)
        #expect(modifiedRecipes.count == 3, "Incorrect recipes count after adding a new one")
        #expect(modifiedRecipes[2].name == "Pasta", "Name should be Pasta")
    }

    @MainActor
    @Test("Recipe removing")
    func testRecipeRemoving() async throws {
        let recipes = [recipe1, recipe2, recipe3]
        let mockService = MockRecipesService(recipes: recipes, error: nil)

        let model = RecipesModel(recipesService: mockService)
        await model.fetchRecipes()

        let originalRecipes = try #require(model.recipes.value)
        #expect(originalRecipes.count == 3, "Incorrect recipes count")

        model.removeRecipe(id: recipe2.id)

        let modifiedRecipes = try #require(model.recipes.value)
        #expect(modifiedRecipes.count == 2, "Incorrect recipes count after removing one")
        #expect(modifiedRecipes[1].name == "Pasta", "Name should be Pasta")
    }
}


