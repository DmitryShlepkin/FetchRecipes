//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
    
    init() {
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            RecipeListView()
                .preferredColorScheme(.light)
                .environmentObject(RecipeListViewModel())
        }
    }
    
    private func registerDependencies() {
        DependencyContainer.register(type: NetworkManagable.self, NetworkManager())
        DependencyContainer.register(type: ImageManagable.self, ImageManager())
    }
    
}
