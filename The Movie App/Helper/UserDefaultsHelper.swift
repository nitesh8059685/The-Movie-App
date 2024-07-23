//
//  UserDefaultsHelper.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.

import Foundation

// Class to handle saving, removing, and loading favorite movies using UserDefaults
class UserDefaultsHelper {
    
    // Key for accessing favorite movies in UserDefaults
    static let favoriteMoviesKey = "favoriteMovies"
    
    // Method to remove a movie from the favorites list
    static func removeItemFromFavorites(_ item: String) {
        var favoriteMovies = UserDefaults.standard.array(forKey: favoriteMoviesKey) as? [String] ?? []
        if let index = favoriteMovies.firstIndex(of: item) {
            favoriteMovies.remove(at: index)
            UserDefaults.standard.set(favoriteMovies, forKey: favoriteMoviesKey)
            print("Removed \(item) from favorites: \(favoriteMovies)")
        }
    }
    
    // Method to add a movie to the favorites list
    static func addItemToFavorites(_ item: String) {
        var favoriteItems = UserDefaults.standard.array(forKey: favoriteMoviesKey) as? [String] ?? []
        if !favoriteItems.contains(item) {
            favoriteItems.append(item)
            UserDefaults.standard.set(favoriteItems, forKey: favoriteMoviesKey)
            print("Added \(item) to favorites: \(favoriteItems)")
        }
    }
    
    // Method to load the list of favorite movies
    static func loadFavoriteItems() -> [String] {
        return UserDefaults.standard.array(forKey: favoriteMoviesKey) as? [String] ?? []
    }
    
}
