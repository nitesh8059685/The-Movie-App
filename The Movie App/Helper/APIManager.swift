//
//  APIManager.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit

// Singleton Design Pattern
class APIManager: APIManagerProtocol {
    
    // Shared singleton instance
    static let shared = APIManager()
    var session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Type alias for the completion handler
    typealias MovieCompletionHandler = (Result<Movie, Error>) -> Void
    
    // Method to fetch movies using a completion handler
    func fetchMovies(completion: @escaping MovieCompletionHandler) {
        guard let url = URL(string: Constant.API.movieURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        // Create a data task to fetch the movie data
        let task = session.dataTask(with: url) { data, response, error in
            
            // Handle any errors
            if let error = error {
                completion(.failure(error))
                return
            }
            // Ensure the response is valid and within the 200-299 range
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                return
            }
            
            // Ensure data was received
            guard let data = data else {
                completion(.failure(NSError(domain: "NO Data Recieved", code: -1, userInfo: nil)))
                return
            }
            
            // Decode the data into an array of Movie objects
            do {
                let decodedData = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    // Method to configure the session, useful for dependency injection in tests
    func configure(with session: URLSession) {
        self.session = session
    }
}
