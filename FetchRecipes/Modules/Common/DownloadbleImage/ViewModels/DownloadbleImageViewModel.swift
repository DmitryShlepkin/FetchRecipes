//
//  DownloadbleImageViewModel.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/4/25.
//

import UIKit

final class DownloadbleImageViewModel: ObservableObject {
        
    @Dependency private var imageManager: ImageManagable?
    private var downloadTask: Task<Void, Error>?
    
    @Published var isLoading: Bool = false
    @Published var image: UIImage? = nil
    
    func download(url: String?) async throws {
        guard let url, !url.isEmpty else { return }
        let task = Task {
            await update(isLoading: true)
            if let image = try await imageManager?.downloadImage(url: url) {
                await MainActor.run {
                    self.image = image
                }
                await update(isLoading: false)
            }
        }
        downloadTask = task
        try await task.value
    }
    
    /// Update isLoading on main thread
    @MainActor internal func update(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    deinit {
        downloadTask?.cancel()
    }

}
