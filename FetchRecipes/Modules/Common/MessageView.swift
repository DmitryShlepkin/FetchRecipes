//
//  MessageView.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/4/25.
//

import SwiftUI

struct MessageView: View {
    
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(.body, design: .rounded))
            Text(description)
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color.gray)
        }
    }
    
}

#Preview {
    MessageView(
        title: "Title",
        description: "Description"
    )
}
