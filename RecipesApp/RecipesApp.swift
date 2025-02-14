//
//  RecipesApp.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import SwiftUI

@main
struct RecipesApp: App {
    let source = DataSource.local

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(
                    RecipesModel(
                        recipesService: RecipesServiceLocator.find(source: source)
                    )
                )
                .environment(MapModel())
        }
    }
}
