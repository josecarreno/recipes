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
    case malformedURL
    case serverError
    case responseParsing
}

struct RecipesServiceLocator {
    static func find(source: DataSource) -> RecipesService {
        switch source {
        case .local:
            RecipesLocalService()
        case .remote:
            RecipesHttpService(baseURL: "http://localhost:8080")
        }
    }
}

enum DataSource {
    case local
    case remote
}

protocol RecipesService: Sendable {
    func fetch() async throws -> [Recipe]
}

actor RecipesLocalService: RecipesService {
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
        guard let response = try? decoder.decode(RecipesResponse.self, from: data) else {
            throw RecipesServiceError.jsonDecoding
        }

        return response.recipes
    }
}

actor RecipesHttpService: RecipesService {
    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func fetch() async throws -> [Recipe] {
        guard let requestURL = URL(string: baseURL)?.appendingPathComponent("/recipes") else {
            throw RecipesServiceError.malformedURL
        }

        guard let (data, _) = try? await URLSession.shared.data(from: requestURL) else {
            throw RecipesServiceError.serverError
        }


        guard let response = try? JSONDecoder().decode(RecipesResponse.self, from: data) else {
            throw RecipesServiceError.responseParsing
        }

        return response.recipes
    }
}
