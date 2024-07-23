//
//  APIManagerTests.swift
//  The Movie AppTests
//
//  Created by Nitesh Sharma on 23/07/24.
//

import XCTest
@testable import The_Movie_App

final class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!          // Instance of APIManager to be tested
    var mockSession: MockURLSession!     // Mock URLSession to simulate network responses
    
    
    override func setUp() {
        super.setUp()
        // Initialize mock session and API manager before each test
        mockSession = MockURLSession()
        apiManager = APIManager.shared
        apiManager.configure(with: mockSession)
    }
    
    override func tearDown() {
        // Clean up after each test
        mockSession = nil
        apiManager = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        //        Set up the mock data for a successful fetch
        let expectation = self.expectation(description: "FetchMoviesSuccess")
        let mockMovie = Movie(title: "Test Movie", year: "2024", rated: "PG-13", released: "2024-07-23", runtime: "120 min", genre: "Action", director: "Test Director", writer: "Test Writer", actors: "Test Actors", plot: "Test Plot", language: "English", country: "USA", awards: "None", poster: "https://test.poster", ratings: [], metascore: "80", imdbRating: "8.0", imdbVotes: "1000", imdbID: "tt1234567", type: "movie", dvd: "N/A", boxOffice: "N/A", production: "Test Production", website: "N/A", response: "")
        
        //        Configure mock session to return the mock movie data
        mockSession.nextData = try! JSONEncoder().encode(mockMovie)
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://www.omdbapi.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.nextError = nil
        
        var fetchedMovie: Movie?
        var fetchedError: Error?
        
        //        Call fetchMovies and handle the result
        apiManager.fetchMovies { result in
            switch result {
            case .success(let movie):
                fetchedMovie = movie
            case .failure(let error):
                fetchedError = error
            }
            expectation.fulfill()
        }
        
        // Assert: Verify the result of the fetch operation
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchedMovie)
        XCTAssertEqual(fetchedMovie?.title, mockMovie.title)
        XCTAssertNil(fetchedError)
    }
    
    func testFetchMoviesInvalidURL() {
        
        let expectation = self.expectation(description: "FetchMoviesInvalidURL")
        mockSession.nextData = nil
        mockSession.nextResponse = nil
        mockSession.nextError = NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        
        var fetchedMovie: Movie?
        var fetchedError: Error?
        
        
        apiManager.fetchMovies { result in
            switch result {
            case .success(let movie):
                fetchedMovie = movie
            case .failure(let error):
                fetchedError = error
            }
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovie)
        XCTAssertNotNil(fetchedError)
        XCTAssertEqual((fetchedError as NSError?)?.domain, "Invalid URL")
    }
    
    func testFetchMoviesInvalidResponse() {
        
        let expectation = self.expectation(description: "FetchMoviesInvalidResponse")
        mockSession.nextData = nil
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://www.omdbapi.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        mockSession.nextError = nil
        
        var fetchedMovie: Movie?
        var fetchedError: Error?
        
        
        apiManager.fetchMovies { result in
            switch result {
            case .success(let movie):
                fetchedMovie = movie
            case .failure(let error):
                fetchedError = error
            }
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovie)
        XCTAssertNotNil(fetchedError)
    }
    
    func testFetchMoviesNoData() {
        
        let expectation = self.expectation(description: "FetchMoviesNoData")
        
        
        mockSession.nextData = nil
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://www.omdbapi.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.nextError = nil
        
        var fetchedMovie: Movie?
        var fetchedError: Error?
        
        
        apiManager.fetchMovies { result in
            switch result {
            case .success(let movie):
                fetchedMovie = movie
            case .failure(let error):
                fetchedError = error
            }
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(fetchedMovie)
        XCTAssertNotNil(fetchedError)
        XCTAssertEqual((fetchedError as NSError?)?.domain, "NO Data Recieved")
    }
}
