//
//  RecipeService.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import Foundation

class RecipeService{
    //fetching JSON with async/ await 
    func fetchRecipes(from url: URL) async throws -> [Recipe]{
        //asyncronosly initiate network request
        let (data, _) = try await URLSession.shared.data(from: url)
        //decode resposne
        let decoder = JSONDecoder()
        let response = try decoder.decode(RecipesResponse.self, from: data)
        return response.recipes
    }
}
