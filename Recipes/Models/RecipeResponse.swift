//
//  RecipeResponse.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

//list of recipes wrapped in struct
struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}
