//
//  Section.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import SwiftUI

struct MySection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content){
        self.title = title
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 21, weight: .heavy))
                .foregroundColor(Color("Prim"))

            content
                .scrollClipDisabled()

        }
        .scrollClipDisabled()

    }
}

