//
//  model.swift
//  RecipesServer
//
//  Created by Jose Bernardo Carreno Castillo on 13/02/25.
//

import Foundation

enum Model {
    struct Recipe: Codable {
        let id: String
        let name: String
        let description: String
        let smallImage: ImageDetails
        let largeImage: ImageDetails
        let ingredients: [String]
        let origin: String
    }

    struct ImageDetails: Codable {
        let source: String
        let type: ImageSourceType

        static let empty = ImageDetails(source: "", type: .asset)
    }

    enum ImageSourceType: String, Codable {
        case asset
        case remote
    }

    static let recipesData: [Recipe] = [
        Recipe(
            id: "1",
            name: "Paella",
            description: "Delicious Spanish rice dish with seafood and chicken.",
            smallImage: ImageDetails(source: "paella_small", type: .asset),
            largeImage: ImageDetails(source: "https://img.freepik.com/fotos-premium/paella-marisco-tradicional-espanola-sarten-sobre-fondo-blanco_222237-372.jpg?semt=ais_hybrid", type: .remote),
            ingredients: ["Rice", "Seafood", "Chicken", "Saffron", "Peas", "Bell peppers"],
            origin: "Valencia, Spain"
        ),
        Recipe(
            id: "2",
            name: "Tacos",
            description: "Authentic Mexican street food with tortillas and various fillings.",
            smallImage: ImageDetails(source: "tacos_small", type: .asset),
            largeImage: ImageDetails(source: "tacos_large", type: .asset),
            ingredients: ["Tortillas", "Meat (beef, pork, chicken)", "Onions", "Cilantro", "Salsa"],
            origin: "Mexico City, Mexico"
        ),
        Recipe(
            id: "3",
            name: "Pizza Margherita",
            description: "Classic Neapolitan pizza with tomato sauce, mozzarella, and basil.",
            smallImage: ImageDetails(source: "pizza_small", type: .asset),
            largeImage: ImageDetails(source: "pizza_large", type: .asset),
            ingredients: ["Dough", "Tomato Sauce", "Mozzarella", "Basil", "Olive oil"],
            origin: "Naples, Italy"
        ),
        Recipe(
            id: "4",
            name: "Sushi",
            description: "Japanese delicacy with rice, seaweed, and various fillings (fish, vegetables).",
            smallImage: ImageDetails(source: "sushi_small", type: .asset),
            largeImage: ImageDetails(source: "sushi_large", type: .asset),
            ingredients: ["Rice", "Seaweed (Nori)", "Fish (Salmon, Tuna)", "Avocado", "Cucumber"],
            origin: "Japan"
        ),
        Recipe(
            id: "5",
            name: "Pad Thai",
            description: "Popular Thai noodle dish with rice noodles, shrimp, tofu, and peanuts.",
            smallImage: ImageDetails(source: "padthai_small", type: .asset),
            largeImage: ImageDetails(source: "padthai_large", type: .asset),
            ingredients: ["Rice Noodles", "Shrimp", "Tofu", "Peanuts", "Bean Sprouts", "Egg", "Fish Sauce"],
            origin: "Thailand"
        ),
        Recipe(
            id: "6",
            name: "Feijoada",
            description: "A hearty Brazilian black bean stew with various meats.",
            smallImage: ImageDetails(source: "feijoada_small", type: .asset),
            largeImage: ImageDetails(source: "feijoada_large", type: .asset),
            ingredients: ["Black Beans", "Pork", "Beef", "Sausage", "Onions", "Garlic", "Bay Leaf"],
            origin: "Brazil"
        ),
        Recipe(
            id: "7",
            name: "Moussaka",
            description: "A Greek baked dish with layers of eggplant, minced meat, and béchamel sauce.",
            smallImage: ImageDetails(source: "moussaka_small", type: .asset),
            largeImage: ImageDetails(source: "moussaka_large", type: .asset),
            ingredients: ["Eggplant", "Minced Meat (lamb or beef)", "Potatoes", "Onions", "Garlic", "Béchamel Sauce"],
            origin: "Greece"
        ),
        Recipe(
            id: "8",
            name: "Pho",
            description: "A Vietnamese noodle soup with broth, rice noodles, herbs, and meat (usually beef).",
            smallImage: ImageDetails(source: "pho_small", type: .asset),
            largeImage: ImageDetails(source: "pho_large", type: .asset),
            ingredients: ["Rice Noodles", "Beef Broth", "Beef (various cuts)", "Onions", "Ginger", "Star Anise", "Cilantro", "Basil", "Lime"],
            origin: "Vietnam"
        )
    ]
}
