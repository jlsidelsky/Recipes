//
//  RecipeRow.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    @State private var image: Image? = nil
    
    var body: some View {
        HStack{
            if let image = image{
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    // only load image when scrolled to
                    .onAppear {
                        Task {
                            await loadImage()
                        }
                    }
            }
            
            VStack{
                Text(recipe.name)
                Text(recipe.cuisine)
            }
            

        }
    }
    func loadImage() async {
        guard let url = recipe.photoUrlLarge else {
            return
        }
        do {
            let uiImage = try await CacheImages.shared.image(for: url)
            await MainActor.run {
                image = Image(uiImage: uiImage)
            }
        }
        catch{
            
        }
    }
}


#Preview {
//    RecipeRow()
}
