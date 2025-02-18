import SwiftUI

struct AllRecipes: View {
    let recipes: [Recipe]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //default to all cuisines
    @State private var selectedCuisine: String = "All Cuisines"
    
    //create a set of unique cuisines from recipes
    var cuisines: [String] {
        let set = Set(recipes.map { $0.cuisine })
        return Array(set).sorted()
    }
    
   
    //reorder the cuisines putting all cuisines first followed by the selected cuisine if not "all cuisines"
    var reorderedCuisines: [String] {
        if selectedCuisine == "All Cuisines" {
            return ["All Cuisines"] + cuisines.filter { $0 != "All Cuisines" }
        } else {
            var list = ["All Cuisines"]
            list.append(selectedCuisine)
            list.append(contentsOf: cuisines.filter { $0 != "All Cuisines" && $0 != selectedCuisine })
            return list
        }
    }
    
    //filter recipes based on selected
    var filteredRecipes: [Recipe] {
        if selectedCuisine == "All Cuisines" {
            return recipes
        } else {
            return recipes.filter { $0.cuisine == selectedCuisine }
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            
            //grid of recipes
            MySection(title: "All Recipes") {
                //filters button group
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(reorderedCuisines, id: \.self) { cuisine in
                            Button(action: {
                                withAnimation {
                                    selectedCuisine = cuisine
                                }
                            }) {
                                Text(cuisine)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(selectedCuisine == cuisine ? .white : Color("Prim"))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(selectedCuisine == cuisine ? Color("Sec") : Color.clear)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    
                }
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filteredRecipes) { recipe in
                        RecipeCard(recipe: recipe, small: true)
                    }
                }
            }
        }
        
    }
}
