//
//  RecipesService.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import Foundation

enum RecipesServiceError: Error {
    case fileNotFound
    case dataParsing
    case jsonDecoding
}

actor RecipesService {
    func fetch() async throws -> [Recipe] {
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            throw RecipesServiceError.fileNotFound
        }

        // Read from local file.
        guard let data = try? Data(contentsOf: url) else {
            throw RecipesServiceError.dataParsing
        }

        let decoder = JSONDecoder()

        // Decode models from json.
        guard let recipes = try? decoder.decode([Recipe].self, from: data) else {
            throw RecipesServiceError.jsonDecoding
        }

        return recipes
    }
}
