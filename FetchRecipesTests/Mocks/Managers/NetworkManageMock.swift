//
//  NetworkManageMock.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Foundation
@testable import FetchRecipes

class NetworkManagerMock: NetworkManagable {
    
    var response: [Recipe]
    
    init(response: [Recipe]) {
        self.response = response
    }
    
    func request<T>(url urlString: String, parameters: [String : String]?, as type: T.Type) async throws -> T? where T : Decodable, T : Encodable {
        response as? T
    }
    
}


class NetworkManagerWithErrorMock: NetworkManagable {
    
    var response: [Recipe]
    
    init(response: [Recipe]) {
        self.response = response
    }
    
    func request<T>(url urlString: String, parameters: [String : String]?, as type: T.Type) async throws -> T? where T : Decodable, T : Encodable {
        throw NetworkManager.NetworkError.statusCode(statusCode: 500)
    }
    
}
