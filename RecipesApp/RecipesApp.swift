//
//  RecipesApp.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(RecipesModel(recipesService: RecipesLocalService()))
                .environment(MapModel())
        }
    }
}
