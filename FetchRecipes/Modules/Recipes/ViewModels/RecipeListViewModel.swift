//
//  RecipeListViewModel.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Combine

enum RecipeListState {
    case initial
    case loading
    case empty
    case error
    case success
}

enum RecipeListUrls: String {
    case recipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case malformed = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    case empty = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

final class RecipeListViewModel: ObservableObject {
    
    @Dependency private var networkManager: NetworkManagable?
    
    @Published var state: RecipeListState = .initial
    @Published var recipeList: [Recipe] = []
    
    init() {
        Task {
            try await fetchRecipeList()
        }
    }
    
    func fetchRecipeList() async throws {
        do {
            await update(state: .loading)
            let recipes = try await networkManager?.request(
                url: RecipeListUrls.recipes.rawValue,
                parameters: [:],
                as: Recipes.self
            )
            guard let recipeList = recipes?.recipes else {
                await update(state: .error)
                return
            }
            /// Note: Added sleep because service response too fast and to provide smooth user experience and make demo project looking good.
            /// I strongly advise against using it in production.
            try await Task.sleep(for: .seconds(1))
            /// Check recipe list count and set state empty if 0
            if recipeList.count == 0 {
                await update(state: .empty)
                return
            }
            /// Validate recipe list
            if self.isRecipeListValid(recipeList) {
                await update(state: .success)
                await update(recipeList: recipeList)
            } else {
                await update(state: .error)
            }
        } catch {
            await update(state: .error)
        }
    }
    
    /// Update state on main thread
    @MainActor internal func update(state: RecipeListState) {
        self.state = state
    }
    
    /// Update recipeList on main thread
    @MainActor internal func update(recipeList: [Recipe]) {
        self.recipeList = recipeList
    }
    
    /// Validate recipe list.
    /// - Parameters:
    ///   - recipeList: Array of recipes
    /// - Returns: True if all recipes in the list are valid, otherwise false.
    internal func isRecipeListValid(_ recipeList: [Recipe]) -> Bool {
        var isValid = true
        recipeList.forEach { recipe in
            for recipe in recipeList {
                if recipe.isValid == false {
                    isValid = false
                    break
                }
            }
        }
        return isValid
    }
    
}
