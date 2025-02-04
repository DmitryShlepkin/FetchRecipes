//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var viewModel: RecipeListViewModel
    
    var body: some View {
        List(viewModel.recipeList, id: \.self.uuid) { recipe in
            HStack {
                DownloadableImageVew(url: recipe.photo_url_small)
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(recipe.name ?? "")")
                    Text("\(recipe.cuisine ?? "")")
                        .foregroundColor(Color.gray)
                }
            }
        }
        .refreshable {
            Task {
                try await viewModel.fetchRecipeList()
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchRecipeList()
            }
        }
    }
}

#Preview {
    RecipeListView()
        .environmentObject(RecipeListViewModel())
}
