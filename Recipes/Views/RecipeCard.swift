//
//  RecipeCard.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI

struct RecipeCard: View {

    @EnvironmentObject var favoritesManager: FavoritesManager
    @Environment(\.openURL) var openURL


    let recipe: Recipe
    let width: CGFloat?
    let small: Bool
    @State private var image: Image? = nil
    
    init(recipe: Recipe, width: CGFloat? = nil, small: Bool = false) {
            self.recipe = recipe
            self.width = width
            self.small = small
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            ZStack(alignment: .topLeading){
                if let image = image{
                    image
                        .resizable()
                        .aspectRatio(3.0/2.0, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame( height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        
                }
               Button(action: {
                    withAnimation {
                        favoritesManager.toggleFavorite(for: recipe.id)
                    }
                }) {
                    Image(systemName: favoritesManager.isFavorite(recipe.id) ? "heart.fill" : "heart")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                        .padding([.top, .leading], 8)
                }
                
            }
            VStack(alignment: .leading, spacing: 0){
            
                HStack (alignment: .center){
                    Text(recipe.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color("Prim"))
                        .lineLimit(1)
                            .truncationMode(.tail)
                    Spacer()
                    if let sourceURL = recipe.sourceUrl {
                        Button(action: {
                            openURL(sourceURL)
                        }) {
                            Image(systemName: "arrow.up.right.square")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Sec"))
                        }
                        .padding(.top, 4)
                    }
                    
                }
                
            Text(recipe.cuisine)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color("Prim").opacity(0.5))
            }

            
            
        }
        .frame(width: width)
        .onAppear {
            Task {
                await loadImage()
            }
        }
    }
    
    func loadImage() async {
        guard let url = !small ?  recipe.photoUrlLarge  : recipe.photoUrlSmall else {
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
