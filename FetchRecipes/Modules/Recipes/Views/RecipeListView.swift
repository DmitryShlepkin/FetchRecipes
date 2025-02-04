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
        Text("\(viewModel.state)")
        List(viewModel.recipeList, id: \.self) { item in
            Text("1")
        }
        .refreshable {
            print("Pull to refresh")
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
