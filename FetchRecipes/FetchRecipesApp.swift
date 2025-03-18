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
        }
    }
    
    private func registerDependencies() {
        DependencyManager.register(type: NetworkManagable.self, NetworkManager())
        DependencyManager.register(type: ImageManagable.self, ImageManager())
    }
    
}
