//
//  RecipeListMock.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Foundation
@testable import FetchRecipes

class RecipeListMock {
    
    static var validList: Recipes {
        Recipes(recipes: [
            getValidRecipe(),
            getValidRecipe(),
            getValidRecipe()
        ])
    }

    static var invalidList: Recipes {
        Recipes(recipes: [
            getValidRecipe(),
            getInvalidRecipe(),
            getValidRecipe()
        ])
    }
    
    private static func getValidRecipe() -> Recipe {
        .init(
            cuisine: "Test",
            name: "Test",
            photo_url_large: nil,
            photo_url_small: nil,
            uuid: UUID(),
            source_url: nil,
            youtube_url: nil
        )
    }
    
    private static func getInvalidRecipe() -> Recipe {
        .init(
            cuisine: "Test",
            name: nil,
            photo_url_large: nil,
            photo_url_small: nil,
            uuid: UUID(),
            source_url: nil,
            youtube_url: nil
        )
    }
    
}
