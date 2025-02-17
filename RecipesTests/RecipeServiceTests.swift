//
//  RecipeServiceTests.swift
//  RecipesTests
//
//  Created by Josh Sidelsky on 2/17/25.
//

import XCTest

final class RecipeServiceTests: XCTestCase {

    //test for valid json
    func testFetchRecipesSuccess() async throws{
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        let service = RecipeService()
        let recipes = try await service.fetchRecipes(from: url!)
        XCTAssertFalse(recipes.isEmpty, "Failed to parse valid JSON")
    }
    
    //test for json with empty recipes array
    func testFetchRecipesEmpty() async throws{
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
        let service = RecipeService()
        let recipes = try await service.fetchRecipes(from: url!)
        XCTAssertEqual(recipes.count, 0, "Returned non-empty recipes array for empty JSON")
    }

    //test for malformed json
    func testFetchRecipesMalformed() async throws{
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        let service = RecipeService()
        do {
            _ = try await service.fetchRecipes(from: url!)
            XCTFail("Decoding didn't fail with malformed JSON")
        } catch{
            XCTAssertTrue(error is DecodingError, "Got non decoding error with malformed JSON")
        }
    }

}
