import Vapor

func routes(_ app: Application) throws {
    let recipesServer = RecipesServer()

    app.get { req async in
        "Try to get some recipes from the /recipes path."
    }

    app.get("recipes") { req async -> RecipesServer.Response.Recipes in
        return recipesServer.listRecipes(request: req)
    }
}

struct RecipesServer {
    func listRecipes(request: Request) -> Response.Recipes {
        return Response.Recipes(recipes: Model.recipesData)
    }

    enum Response {
        struct Recipes: Content {
            var recipes: [Model.Recipe]
        }
    }
}
