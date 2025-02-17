//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    //create an enum to store all the possible states for the viewModel
    enum loadingState{
        case idle
        case loading
        case success(recipes: [Recipe])
        case emptyData
        case malformedData
        case failure
    }
    
    // initialize  state to idle
    @Published var state: loadingState = .idle
    private let service = RecipeService()
    
   
    func loadRecipes(from url: URL) async {
        // set state to loading once we attempt to load the data
        state = .loading
        do {
            let fetchedRecipes = try await service.fetchRecipes(from: url)
            if fetchedRecipes.isEmpty {
                state = .emptyData
            }
            else {
                state = .success(recipes: fetchedRecipes)
            }
        }
        //set state to malformedData if we fail to decode or failure if there is any other kind of error
        catch{
            print("Error loading recipes: \(error)")
            if error is DecodingError{
                state = .malformedData
            }
            else {
                state = .failure
            }
        }
    }
}
