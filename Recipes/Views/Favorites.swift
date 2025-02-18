//
//  Favorites.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI

struct Favorites: View {
    let recipes: [Recipe]
    
    @EnvironmentObject var favoritesManager: FavoritesManager

        // filter recipes by favorited
    var favoritedRecipes: [Recipe] {
        recipes.filter { favoritesManager.isFavorite($0.id) }
    }

    var body: some View {
        MySection(title: "Favorites" ){
            if favoritedRecipes.isEmpty {
                Text("No favorites yet")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(favoritedRecipes) { recipe in
                            RecipeCard(recipe: recipe, width: 256)
                                
                        }
                    }
                }
                .scrollClipDisabled()
                
            }
            
        }
    }
}
