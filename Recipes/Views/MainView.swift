//
//  MainView.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = RecipesViewModel()
    let endPoint: URL
    @StateObject private var favoritesManager = FavoritesManager()


    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.vertical){
                    VStack (alignment: .leading){
                        Text("Our Recipes")
                            .font(.system(size: 36, weight: .black))
                            .padding(.vertical, 16)
                            .foregroundStyle(Color("Sec"))
                        getView()
                    }
                }
                .scrollClipDisabled()
                .refreshable {
                    await viewModel.loadRecipes(from: endPoint)
                }
                .task {
                    await viewModel.loadRecipes(from: endPoint)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }.environmentObject(favoritesManager)


      
            
    }
    @ViewBuilder
    private func getView() -> some View {
        //handle state of data
        switch viewModel.state {
            
        case .idle, .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        case .success(recipes: let recipes):
            VStack(alignment: .leading, spacing: 12){
                Favorites(recipes: recipes)
                AllRecipes(recipes: recipes)            .environmentObject(favoritesManager)
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
    MainView(endPoint: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!)

}
