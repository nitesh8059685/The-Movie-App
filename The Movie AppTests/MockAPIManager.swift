//
//  MockAPIManager.swift
//  The Movie AppTests
//
//  Created by Nitesh Sharma on 23/07/24.
//

import Foundation
@testable import The_Movie_App

// Mock APIManager for testing
class MockAPIManager: APIManagerProtocol {
    var mockResult: Result<Movie, Error> = .success(Movie(
        title: "Mock Movie",
        year: "2024",
        rated: "PG",
        released: "01 Jan 2024",
        runtime: "120 min",
        genre: "Action",
        director: "Jane Doe",
        writer: "John Doe",
        actors: "Actor One, Actor Two",
        plot: "A thrilling mock movie.",
        language: "English",
        country: "USA",
        awards: "None",
        poster: "https://example.com/mockposter.jpg",
        ratings: [
            Rating(source: "Mock Source", value: "9.0/10")
        ],
        metascore: "N/A",
        imdbRating: "9.0",
        imdbVotes: "1,000",
        imdbID: "tt0000000",
        type: "movie",
        dvd: "01 Feb 2024",
        boxOffice: "$100,000,000",
        production: "Mock Production",
        website: "https://example.com",
        response: "True"
    ))
    
    func fetchMovies(completion: @escaping (Result<Movie, Error>) -> Void) {
        completion(mockResult)
    }
}
