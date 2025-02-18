//
//  FavoritesManager.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import Foundation
import SwiftUI

final class FavoritesManager: ObservableObject {
    
    //store ids of favorited recipes
    @Published var favorites: Set<UUID> = []
    
    func toggleFavorite(for recipeID: UUID) {
        if favorites.contains(recipeID) {
            favorites.remove(recipeID)
        } else {
            favorites.insert(recipeID)
        }
    }
    
    func isFavorite(_ recipeID: UUID) -> Bool {
        favorites.contains(recipeID)
    }
}
