//
//  APIManager.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 03/07/24.
//

import UIKit

enum DataError: Error, LocalizedError {
    case invalidResponse
    case invalidURL
    case network(Error?)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The response is invalid."
        case .invalidURL:
            return "The URL failed."
        case .network:
            return "Failed to decode the data."
        }
    }
}

// Singleton Design Pattern
class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    //NOTE: I am using URLSession and async/await to fetch data asynchronously.
    func request<T: Decodable>(url: String) async throws -> T {
        
        guard let url = URL(string:url) else {
            throw DataError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw DataError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch {
            throw error
        }
    }
}

