//
//  Recipe.swift
//  Recipes
//
//  Created by Jose Carreno Castillo.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let smallImage: String
    let largeImage: String
    let ingredients: [String]
    let origin: String
}
