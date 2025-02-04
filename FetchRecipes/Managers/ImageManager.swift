//
//  ImageManager.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import UIKit
import Foundation
import Combine

protocol ImageManagable {
    func downloadImage(url: String) async throws -> UIImage?
}

final class ImageManager: ImageManagable {
        
    enum ImageError: Error {
        case data
        case network
    }
    
    private let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    private let folderName = "photos"
    
    init() {
        createFolderIfNeeded()
    }

}

// MARK: - Public
extension ImageManager {
    
    func downloadImage(url: String) async throws -> UIImage? {
        guard let fileName = getFileNameFrom(url: url) else { return nil }
        if let image = loadImageFromDisk(named: fileName) {
            return image
        } else {
            if let image = try await downloadImageFrom(url: url) {
                saveImageToDisk(image: image, named: fileName)
            }
        }
        return nil
    }
    
}


// MARK: - Private
private extension ImageManager {
 
    /// - Returns: path to folder with images.
    func getFolderPath() -> URL? {
        directoryURL?.appendingPathComponent(folderName)
    }
    
    /// Check folder path and create it if folder doesn't exit.
    func createFolderIfNeeded() {
        guard
            let folderPath = getFolderPath(),
            FileManager.default.fileExists(atPath: folderPath.path) == false
        else { return }
        do {
            try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Format url from "https://aaa.bbb/ccc/ddd/image.jpg" to "https-aaa-bbb-ccc-ddd-image.jpg"
    /// - Parameters:
    ///   - url: URL string.
    /// - Returns: File name with extension.
    func getFileNameFrom(url: String) -> String? {
        var parts = url.components(separatedBy: ["/", ".", ":"])
        guard let ext = parts.popLast(), !ext.isEmpty else { return nil }
        let joined = parts
            .filter { !$0.isEmpty }
            .joined(separator: "-")
        return "\(joined).\(ext)"
    }
    
    
    /// Download image from url.
    /// - Parameters:
    ///   - url: URL string.
    /// - Returns: Downloaded image as UIImage.
    func downloadImageFrom(url urlString: String) async throws -> UIImage? {
        let url = URL(string: urlString)
        guard let url else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        if let UIImage = UIImage(data: data) {
            return UIImage
        }
        return nil
    }
    
    /// Save image to disk.
    /// - Parameters:
    ///   - image: image data.
    ///   - named: Image file name.
    func saveImageToDisk(image: UIImage, named fileName: String) {
        guard let folderPath = getFolderPath() else { return }
        let fileURL = folderPath.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return }
        do {
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Load image from disk.
    /// - Parameters:
    ///   - named: Image file name.
    /// - Returns: Loaded image as UIImage.
    func loadImageFromDisk(named fileName: String) -> UIImage? {
        guard let folderPath = getFolderPath() else { return nil }
        let fileURL = folderPath.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
