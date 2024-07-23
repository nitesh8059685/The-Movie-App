//
//  FavoriteListViewController.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!   // Table view to display the list of favorite movies
    var movieListViewController = MovieListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register MovieCell.xib for the table view
        let nib = UINib(nibName: "FavoriteListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavoriteMovieCell")
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource, ReloadTaleViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favoriteMovies = UserDefaultsHelper.loadFavoriteItems()
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as? FavoriteListCell else {
            return UITableViewCell()
        }
        let favoriteMovies = UserDefaultsHelper.loadFavoriteItems()
        cell.favoriteConfigure(with: favoriteMovies, at: indexPath)
        cell.favoriteListDelegate = self
        return cell
    }

    // Reloads the table view data
    func reloadTableView() {
        tableView.reloadData()
    }

}
