//
//  MovieViewModelTests.swift
//  The Movie AppTests
//
//  Created by Nitesh Sharma on 23/07/24.
//

import XCTest
@testable import The_Movie_App

final class MovieViewModelTests: XCTestCase {
    
    var viewModel: MovieViewModel!   // The ViewModel instance to be tested
    var mockAPIManager: MockAPIManager!  // The mock API manager to simulate network responses
    
    var didFetchMoviesCalled = false
    var didEncounterErrorCalled = false
    var receivedErrorMessage: String?
    
    override func setUp() {
        super.setUp()
        // Initialize the mock API manager
        mockAPIManager = MockAPIManager()
        viewModel = MovieViewModel()
        // Initialize the ViewModel with the mock API manager
        viewModel = MovieViewModel(apiManager: mockAPIManager)
        viewModel.delegate = self
    }
    override func tearDown() {
        // Clean up after each test
        viewModel = nil
        mockAPIManager = nil
        didFetchMoviesCalled = false
        didEncounterErrorCalled = false
        receivedErrorMessage = nil
        super.tearDown()
    }
    
    // Test case for successful movie fetch
    func testFetchMoviesSuccess() {
        // Create a mock movie object for the test
        let expectedMovie = Movie(
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
        )
        
        mockAPIManager.mockResult = .success(expectedMovie)
        
        let expectation = XCTestExpectation(description: "Fetch movies")
        // Trigger the fetch movies method
        viewModel.fetchMovies()
        
        // Check the result after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.didFetchMoviesCalled)
            XCTAssertEqual(self.viewModel.movies.first?.title, expectedMovie.title)
            XCTAssertEqual(self.viewModel.movies.first?.year, expectedMovie.year)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    // Test case for failed movie fetch
    func testFetchMoviesFailure() {
        // Given
        let expectedError = NSError(domain: "Test", code: -1, userInfo: nil)
        mockAPIManager.mockResult = .failure(expectedError)
        
        let expectation = XCTestExpectation(description: "Fetch movies")
        // Trigger the fetch movies method
        viewModel.fetchMovies()
        
        // Check the result after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.didEncounterErrorCalled)
            XCTAssertEqual(self.receivedErrorMessage, expectedError.localizedDescription)
            XCTAssertTrue(self.viewModel.movies.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
}

// MARK: - MovieViewModelDelegate
extension MovieViewModelTests: MovieViewModelDelegate {
    func didFetchMovies() {
        didFetchMoviesCalled = true
    }
    
    func didEncounterError(_ errorMessage: String) {
        didEncounterErrorCalled = true
        receivedErrorMessage = errorMessage    }
}
