//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import SwiftUI

struct RecipeListView: View {
    var body: some View {
        List {
            Text("1")
            Text("2")
            Text("3")
        }
        .refreshable {
            print("Pull to refresh")
        }
    }
}

#Preview {
    RecipeListView()
}
