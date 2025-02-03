//
//  NetworkManager.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Foundation

protocol NetworkManagable {
    func request<T:Codable>(url urlString: String, parameters: [String: String]?, as type: T.Type) async throws -> T?
}

final class NetworkManager: NetworkManagable {
        
    enum NetworkError: Error {
        case statusCode(statusCode: Int)
    }
    
    /// Request Data from network.
    /// - Parameters:
    ///   - url: URL string.
    ///   - parameters: Dictionary with request get parameters.
    ///   - as: Response type, used for decode data from response
    /// - Returns: Decoded data.
    func request<T:Codable>(url urlString: String, parameters: [String: String]? = nil, as type: T.Type) async throws -> T? {
        
        var urlComponents = URLComponents(string: urlString)
        
        if let parameters {
            let queryItems: [URLQueryItem]? = parameters.keys.map { key in
                URLQueryItem(name: key, value: parameters[key])
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.statusCode(statusCode: -1)
        }

        guard (200...299).contains(statusCode) else {
            throw NetworkError.statusCode(statusCode: statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
            
}
