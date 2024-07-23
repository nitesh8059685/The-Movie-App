//
//  MovieListViewController.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    private var viewModel = MovieViewModel()   // ViewModel instance to manage movie data
    private var filteredMovies: [Movie] = []   // Array to store filtered movies based on search
    private var isSearching = false           // Boolean to track if the user is searching
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set up table view
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        
        // Register MovieCell.xib for the table view
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        movieListTableView.register(nib, forCellReuseIdentifier: "MovieCell")
        
        // Set the ViewModel delegate and fetch movies
        viewModel.delegate = self
        viewModel.fetchMovies()
        
        // Set up search bar
        movieSearch.delegate = self
        print(filteredMovies)
        
    }
    
    // function to show an alert
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        cell.movieConfigure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Deselect the row
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController{
            let movie = filteredMovies[indexPath.row]
            detailVC.selectedMovie = movie
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MovieListViewController: MovieViewModelDelegate {
    
    // Method called when movies are successfully fetched
    func didFetchMovies() {
        filteredMovies = viewModel.movies
        movieListTableView.reloadData()
    }
    
    // Method called when an error occurs during fetching
    func didEncounterError(_ error: String) {
        showAlert(title: "Error", message: error)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    // Handle search bar text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = viewModel.movies
            isSearching = false
        } else {
            isSearching = true
            filteredMovies = viewModel.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        movieListTableView.reloadData()
    }
    // Handle search bar cancel button click
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filteredMovies = viewModel.movies
        movieListTableView.reloadData()
    }
}
