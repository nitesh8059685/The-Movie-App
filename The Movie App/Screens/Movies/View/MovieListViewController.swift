//
//  MovieListViewController.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 03/07/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    private var viewModel = MovieViewModel<Movie>()
    private var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        movieListTableView.dataSource = self
        
        // Register MovieCell.xib for the table view
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        movieListTableView.register(nib, forCellReuseIdentifier: "MovieCell")
        
        Task {
            await viewModel.fetchMovies(from: Constant.API.movieURL)
        }
        
    }
    
}

extension MovieListViewController {
    
    private func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieListViewController: MovieViewModelDelegate {
    func didUpdateMovies<T>(_ movies: [T]) where T : Decodable {
        guard let movies = movies as? [Movie] else { return }
        self.movies = movies
        movieListTableView.reloadData()
    }
    
    func didEncounterError(_ error: String) {
        displayError(error)
    }
    
    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        print(movie)
        cell.movieConfigure(with: movie)
        return cell    }
    
    
}
