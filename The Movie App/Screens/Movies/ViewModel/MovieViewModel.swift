//
//  MovieViewModel.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 03/07/24.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func didUpdateMovies<T: Decodable>(_ movies: [T])
    func didEncounterError(_ error: String)
}

@MainActor
class MovieViewModel<T: Decodable> {
    
    weak var delegate: MovieViewModelDelegate?
    private(set) var movies: [T] = []
    
    func fetchMovies(from urlString: String) async {
        do {
            let movies: [T] = try await APIManager.shared.request(url: urlString)
            self.movies = movies
            delegate?.didUpdateMovies(movies)
        } catch {
            delegate?.didEncounterError(error.localizedDescription)
        }
    }
}
