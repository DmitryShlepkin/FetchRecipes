//
//  View+Extension.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/4/25.
//

import SwiftUI

extension View {
    func visible(_ isVisible: Bool) -> some View {
        modifier(VisibleModifier(isVisible: isVisible))
    }
}

fileprivate struct VisibleModifier: ViewModifier {
    let isVisible: Bool
    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            } else {
                EmptyView()
            }
        }
    }
}

