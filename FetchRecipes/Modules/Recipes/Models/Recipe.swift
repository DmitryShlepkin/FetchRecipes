//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Foundation

struct Recipe {
    
    let cuisine: String?
    let name: String?
    let photo_url_large: String?
    let photo_url_small: String?
    let uuid: UUID?
    let source_url: String?
    let youtube_url: String?
    
    var isValid: Bool {
        guard
            cuisine != nil,
            name != nil,
            uuid != nil else { return false }
        return true
    }
    
}
