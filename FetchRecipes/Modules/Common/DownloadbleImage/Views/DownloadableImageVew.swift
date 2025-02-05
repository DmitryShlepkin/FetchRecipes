//
//  DownloadableImageVew.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import SwiftUI

struct DownloadableImageVew: View {
    
    @StateObject private var loader: DownloadbleImageViewModel
    private let url: String?
    
    init(url: String?) {
        self.url = url
        _loader = StateObject(wrappedValue: DownloadbleImageViewModel())
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
            .onAppear() {
                Task { [self] in
                    try await self.loader.download(url: url)
                }
            }
    }
    
}
