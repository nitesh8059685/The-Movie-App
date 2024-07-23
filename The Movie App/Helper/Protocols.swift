//
//  Protocols.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func didFetchMovies()  // Called when movies are successfully fetched
    func didEncounterError(_ error: String)  // Called when an error occurs during fetching
}

// Protocol for reloading the table view
protocol ReloadTaleViewDelegate: AnyObject {
    func reloadTableView()
}


// Protocol for updating the favorite button's state
protocol UpdateFavoriteButtonDelegate: AnyObject {
    func updateFavoriteButton(for movie: String)
}

// Protocol for API Manager to fetch movies
protocol APIManagerProtocol {
    func fetchMovies(completion: @escaping (Result<Movie, Error>) -> Void)
}
