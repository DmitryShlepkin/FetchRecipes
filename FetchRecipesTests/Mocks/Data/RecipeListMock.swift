//
//  RecipeListMock.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Foundation
@testable import FetchRecipes

class RecipeListMock {
    
    static let validList: [Recipe] = [
        getValidRecipe(),
        getValidRecipe(),
        getValidRecipe()
    ]
    
    
    static let invalidList: [Recipe] = [
        getValidRecipe(),
        getInvalidRecipe(),
        getValidRecipe()
    ]
    
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
