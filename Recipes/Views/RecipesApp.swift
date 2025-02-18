//
//  RecipesApp.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(endPoint:  URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!)
        }
    }
}
