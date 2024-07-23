//
//  MovieViewModel.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import Foundation

class MovieViewModel {
    
    weak var delegate: MovieViewModelDelegate?      // Delegate to communicate with the ViewController
    var movies: [Movie] = []
    private var apiManager: APIManagerProtocol
    
    // Initializer to accept APIManagerProtocol
       init(apiManager: APIManagerProtocol = APIManager.shared) {
           self.apiManager = apiManager
       }
    
    
    // Method to fetch movies from the API
    func fetchMovies() {
        apiManager.fetchMovies { [weak self] result in
            guard let self = self else { return }
            
            // Execute UI updates on the main thread
            DispatchQueue.main.async {
                switch result {
                case .success(let newMovies):
                    self.movies.append(newMovies)
                    self.delegate?.didFetchMovies()
                case .failure(let error):
                    self.delegate?.didEncounterError(error.localizedDescription)
                }
            }
        }
    }
}
