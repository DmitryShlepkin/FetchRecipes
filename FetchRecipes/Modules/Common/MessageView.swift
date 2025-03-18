//
//  MessageView.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/4/25.
//

import SwiftUI

struct MessageView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(.body, design: .rounded))
                .dynamicTypeSize(...dynamicTypeSize)
                .accessibilityLabel(title)
            Text(description)
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color.gray)
                .dynamicTypeSize(...dynamicTypeSize)
                .accessibilityLabel(description)
        }
    }
    
}

#Preview {
    MessageView(
        title: "Title",
        description: "Description"
    )
}
