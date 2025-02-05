//
//  DownloadbleImageViewModel.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/4/25.
//

import UIKit

final class DownloadbleImageViewModel: ObservableObject {
    
    @Dependency private var imageManager: ImageManagable?
    
    @Published var isLoading: Bool = false
    @Published var image: UIImage? = nil
    
    func download(url: String?) async throws {
        guard let url, !url.isEmpty else { return }
        await update(isLoading: true)
        if let image = try await imageManager?.downloadImage(url: url) {
            await MainActor.run {
                self.image = image
            }
            await update(isLoading: false)
        }
    }
    
    /// Update isLoading on main thread
    @MainActor internal func update(isLoading: Bool) {
        self.isLoading = isLoading
    }
    

}
