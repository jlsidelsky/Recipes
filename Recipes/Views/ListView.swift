//
//  ListView.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = RecipesViewModel()
    let endPoint: URL
    

    var body: some View {
        NavigationView {
            getView()
                .navigationTitle("Recipes")
                .refreshable {
                    await viewModel.loadRecipes(from: endPoint)
                }
                .task {
                    await viewModel.loadRecipes(from: endPoint)
                }
            }
    }
    @ViewBuilder
    private func getView() -> some View {
        //handle state of data
        switch viewModel.state {
            
        case .idle, .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //return simple list to test
        case .success(recipes: let recipes):
            List(recipes) { recipe in
                RecipeRow(recipe: recipe)
            }
        
        case .emptyData:
            Text("No recipes available")
                .padding()
        case .malformedData:
            Text("Malformed data")
                .padding()
        case .failure:
            Text("Failed to load recipes. Please try again!")
                .padding()
            
        }
    }
        
}

#Preview {
    ListView(endPoint: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!)
}
