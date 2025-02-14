//
//  Recipe.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import Foundation

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let smallImage: ImageDetails
    let largeImage: ImageDetails
    let ingredients: [String]
    let origin: String
}

struct ImageDetails: Decodable {
    let source: String
    let type: ImageSourceType

    static let empty = ImageDetails(source: "", type: .asset)
}

enum ImageSourceType: String, Decodable {
    case asset
    case remote
}
