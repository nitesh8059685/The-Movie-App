//
//  MovieCell.swift
//  The Movie App
//
//  Created by Nitesh Sharma on 23/07/24.
//

import UIKit

class MovieCell: UITableViewCell {
    
    // Outlets for UI elements in the cell
    @IBOutlet weak var movieListBackgroundView: UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieListBackgroundView.clipsToBounds = false
        movieListBackgroundView.layer.cornerRadius = 15
        moviePoster.layer.cornerRadius = 10
        movieListBackgroundView.backgroundColor = .systemGray6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        
        guard let movieName = sender.accessibilityIdentifier else {
            return
        }
        
        var favoriteMovies = UserDefaultsHelper.loadFavoriteItems()
        
        if favoriteMovies.firstIndex(of: movieName) != nil {
            // Remove from favorites
            UserDefaultsHelper.removeItemFromFavorites(movieName)
        } else {
            // Add to favorites
            UserDefaultsHelper.addItemToFavorites(movieName)
        }
        
        
        // Update the button title
        favoriteMovies = UserDefaultsHelper.loadFavoriteItems()
        let buttonTitle = favoriteMovies.contains(movieName) ? "Unfavorite" : "Favorite"
        sender.setTitle(buttonTitle, for: .normal)
    }
    
}

// Extension to configure the cell with a Movie object
extension MovieCell {
    func movieConfigure(with movie: Movie) {
        
        movieTitle.text = movie.title
        movieReleaseDate.text = movie.released
        if let posterURL = URL(string: movie.poster) {   // Load the movie poster image using Kingfisher library
            moviePoster.kf.setImage(with: posterURL)
        } else {
            moviePoster.image = UIImage(named: "posterPlaceHolder") //Setting Placeholder Imagee if url is Invalid
        }
        let favoriteItems = UserDefaultsHelper.loadFavoriteItems()
        let isFavorite = favoriteItems.contains(movie.title)
        let buttonTitle = isFavorite ? "Unfavorite" : "Favorite"
        favoriteButton.setTitle(buttonTitle, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked(_:)), for: .touchUpInside)
        favoriteButton.accessibilityIdentifier = movie.title
    }
}

