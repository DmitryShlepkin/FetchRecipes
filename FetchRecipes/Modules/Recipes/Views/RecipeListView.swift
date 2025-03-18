//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = RecipeListViewModel()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        MessageView(
            title: "No result",
            description: "Please, try again later."
        )
            .visible(viewModel.state == .empty)
        MessageView(
            title: "Error",
            description: "Please, try again later."
        )
            .visible(viewModel.state == .error)
        LoadingView()
            .visible(viewModel.state == .loading)
        List(viewModel.recipeList, id: \.self.uuid) { recipe in
            HStack {
                DownloadableImageVew(url: recipe.photo_url_small)
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4) {
                    if let name = recipe.name {
                        Text("\(name)")
                            .font(.title3)
                            .foregroundColor(.primary)
                            .dynamicTypeSize(...dynamicTypeSize)
                    }
                    if let cuisine = recipe.cuisine {
                        Text("\(cuisine)")
                            .font(.title3)
                            .foregroundColor(Color.gray)
                            .dynamicTypeSize(...dynamicTypeSize)
                    }
                }
            }
            .accessibilityLabel("\(recipe.accessibilityLabel)")
        }
            .visible(viewModel.state == .success)
            .refreshable {
                Task {
                    try await viewModel.fetchRecipeList()
                }
            }
    }
}

#Preview {
    RecipeListView()
}
